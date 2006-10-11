From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [RFC] separate .git from working directory
Date: Thu, 12 Oct 2006 04:46:51 +0700
Message-ID: <fcaeb9bf0610111446i35251fc9i6517cc5b3b53fe84@mail.gmail.com>
References: <fcaeb9bf0610110623q365d3ffcw9ba9e11936d03a9d@mail.gmail.com>
	 <20061011181425.GA10922@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 23:49:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXluv-0000Fu-De
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 23:47:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422651AbWJKVqy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 17:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422660AbWJKVqy
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 17:46:54 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:13642 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422651AbWJKVqw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Oct 2006 17:46:52 -0400
Received: by wx-out-0506.google.com with SMTP id s14so341505wxc
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 14:46:51 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aIdTZoVCceh/FRBTLA6qluiAKPRSp9oXLXPhakXAx7pZYsDdHG0D/lKSo8n5MmN0pvExZyvT6fTYrzpB7h7Z0zQFoVM5nNd9uskuzrUIxrj5fq+q8hRTH3xC9D6qo6+Gq2bJ+AvYRzuc8wZ7zoc4ZqoznO7aXhab9eEtz7Tx1wE=
Received: by 10.70.35.1 with SMTP id i1mr1510038wxi;
        Wed, 11 Oct 2006 14:46:51 -0700 (PDT)
Received: by 10.70.46.13 with HTTP; Wed, 11 Oct 2006 14:46:51 -0700 (PDT)
To: "Martin Waitz" <tali@admingilde.org>
In-Reply-To: <20061011181425.GA10922@admingilde.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28752>

On 10/12/06, Martin Waitz <tali@admingilde.org> wrote:
> For subprojects you really need a shared object repository.
> In such a setup b/.git/objects would be a symlink to the parent
> object directory.
>
> On the other hand, you already have the same problem with
> a/.git/objects.  If you really want to move .git outside of the
> working directory you can always do so by using a symlink for
> the entire .git directory.

I thought about symlinks. However find will follow symlinks and
traverse .git directories again. My goal is to prevent looking into
.git directories

>
> --
> Martin Waitz
-- 
Duy
