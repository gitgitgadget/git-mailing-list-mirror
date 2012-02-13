From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Mon, 13 Feb 2012 22:10:24 +0100
Message-ID: <20120213221024.7315d3c0@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<m3lio8s57v.fsf@localhost.localdomain>
	<20120213075451.1bc20885@mkiedrowicz.ivo.pl>
	<201202132058.18001.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 22:10:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx3Ad-0005VF-Tw
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 22:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201Ab2BMVKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 16:10:41 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57226 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758145Ab2BMVK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 16:10:29 -0500
Received: by eekc14 with SMTP id c14so1998616eek.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 13:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=wSQhahalwL7Ga9kMii/3B8knWdX+X/nWSDcaOIvr4lA=;
        b=uCKKjW+9tj5sI/yuUw8cc/+9lww3/njz6Vuq5fQ0unIMq8DvHCtHN+RamLvQUUDEvo
         Q6gbg8Z7+uneo8Aa0ufoeq2yMFB3lP7TzzCyb5BlK+r4pNdUU8FBDNb71Jhoir8RecDs
         0nqeFSKlOCm0OS7dfboXRdoSj2kMI37T1NIzk=
Received: by 10.213.15.145 with SMTP id k17mr2157293eba.16.1329167428009;
        Mon, 13 Feb 2012 13:10:28 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id v51sm65041813eef.2.2012.02.13.13.10.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 13:10:27 -0800 (PST)
In-Reply-To: <201202132058.18001.jnareb@gmail.com>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190671>

Jakub Narebski <jnareb@gmail.com> wrote:

> Michal Kiedrowicz wrote:
> > Jakub Narebski <jnareb@gmail.com> wrote:
> > > Jakub Narebski <jnareb@gmail.com> writes:
> [...]
> > > > Anyway I have send to git mailing list a patch series, which in one
> > > > of patches adds esc_html_match_hl($str, $regexp) to highlight
> > > > matches in a string.  
> > 
> > Yeah, I saw that but after seeing that they accept different arguments
> > I decided to leave them alone.
> > 
> > > > Your esc_html_mark_range(), after a
> > > > generalization, could be used as underlying "engine".
> > > > 
> > > > Something like this, perhaps (untested):
> > 
> > I think I'll leave it to you after merging both these series to
> > master :)
>  
> Yes, you are right.  Let's do it when we actually need it.
> 

Good :)
