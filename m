From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git-cvsserver won't add new content on update
Date: Fri, 19 Jan 2007 08:01:56 +1300
Message-ID: <46a038f90701181101w1ea300b6lb4d7e4354d89be95@mail.gmail.com>
References: <200701181616.38318.andyparkins@gmail.com>
	 <20070118162222.GE15428@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Andy Parkins" <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 20:02:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7cWR-0000BT-KR
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 20:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbXARTCA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 14:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbXARTCA
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 14:02:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:26509 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932348AbXARTB7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 14:01:59 -0500
Received: by nf-out-0910.google.com with SMTP id o25so265545nfa
        for <git@vger.kernel.org>; Thu, 18 Jan 2007 11:01:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hPsy3eqy5F1AiZGK2IgSrb6TOL789Mz1Xr/2FTox6lz7qFXn65mCok1xMPCxoYmTIulzRTakSNROtWRHseU+nu9oTsxRfCpBj8sljqov2N3Et88RvWqyF3kMElXjV95QirfbebxBZ9sWaHuQke3c2jG1D8iCVLSR65Wq34q9oSY=
Received: by 10.49.57.3 with SMTP id j3mr1174590nfk.1169146916887;
        Thu, 18 Jan 2007 11:01:56 -0800 (PST)
Received: by 10.49.35.7 with HTTP; Thu, 18 Jan 2007 11:01:56 -0800 (PST)
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070118162222.GE15428@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37129>

On 1/19/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> You need to commit first to get the file completely added.
> What you are seeing above is that the file was listed in
> some/sub/directory/CVS/Entries so that the next commit will
> know to upload the file to the server.  Until then its not
> actually going to do that...

yup. Also make sure you are using a really recent git-cvsserver, I
recently fixed a couple of problems related to file adds.

cheers.


martin
