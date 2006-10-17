From: "Ryan Anderson" <rda@google.com>
Subject: Re: [PATCH] add proper dependancies on the xdiff source
Date: Tue, 17 Oct 2006 11:22:41 -0700
Message-ID: <87dcb0bd0610171122o29be7d66r31ef60ef714ca536@mail.gmail.com>
References: <Pine.LNX.4.64.0610171005370.3962@g5.osdl.org>
	 <2ffb978570666d608b8a58c39e30b9d1@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 20:37:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZtoJ-00065K-Ne
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 20:37:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWJQSWs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 14:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWJQSWs
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 14:22:48 -0400
Received: from smtp-out.google.com ([216.239.45.12]:37435 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750793AbWJQSWr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 14:22:47 -0400
Received: from zps78.corp.google.com (zps78.corp.google.com [172.25.146.78])
	by smtp-out.google.com with ESMTP id k9HIMjGs013022
	for <git@vger.kernel.org>; Tue, 17 Oct 2006 11:22:45 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=JlWGGlYqkUpZU2sqTX5MV4XzSZkinmJZmC3bwOWgOtga9TelQUgSxaq7cgSBL+j9u
	EhwHBY4FefcP5z4TdWOwg==
Received: from nz-out-0102.google.com (nzdx3.prod.google.com [10.36.150.3])
	by zps78.corp.google.com with ESMTP id k9HIMfCe014678
	for <git@vger.kernel.org>; Tue, 17 Oct 2006 11:22:41 -0700
Received: by nz-out-0102.google.com with SMTP id x3so2074nzd
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 11:22:41 -0700 (PDT)
Received: by 10.65.186.18 with SMTP id n18mr12723157qbp;
        Tue, 17 Oct 2006 11:22:41 -0700 (PDT)
Received: by 10.64.83.11 with HTTP; Tue, 17 Oct 2006 11:22:41 -0700 (PDT)
To: "Andy Whitcroft" <apw@shadowen.org>
In-Reply-To: <2ffb978570666d608b8a58c39e30b9d1@pinky>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29101>

On 10/17/06, Andy Whitcroft <apw@shadowen.org> wrote:
> We are not rebuilding the xdiff library when its header files change.
> Add dependancies for those to the main Makefile.
>
> Signed-off-by: Andy Whitcroft <apw@shadowen.org>

Acked-by: Ryan Anderson <ryan@google.com>

(I had a different variation on the same change just about ready to
mail, but the dependencies match.  For a simple verification, "gcc -MM
xdiff.c" is a good tool.)
