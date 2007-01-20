From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: MinGW port - initial work uploaded
Date: Sat, 20 Jan 2007 21:21:25 +0100
Message-ID: <46d6db660701201221t786b0918o6b218108a8cb1545@mail.gmail.com>
References: <200701192148.20206.johannes.sixt@telecom.at>
	 <20070120033149.GB11200@spearce.org>
	 <200701202105.23861.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 20 21:22:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8Mj9-0005e2-GX
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 21:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965372AbXATUV2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 15:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965377AbXATUV2
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 15:21:28 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:46511 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965372AbXATUV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 15:21:26 -0500
Received: by nf-out-0910.google.com with SMTP id o25so838583nfa
        for <git@vger.kernel.org>; Sat, 20 Jan 2007 12:21:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I+xvzbU/jyHEXAbza/ZRCAcrhcMCGYgauoYXFgO3Nm+rekRcF2BefZLGrKtMRfyJ42qDeXnaEaz7JN7de8FFM4Y9n+3LNFoyXb8o+kIhM2alGIEMsXBLIdO92BfEp976NWJx2XoskdbvXYamUuzfYu1KBd3VK5qd/KHm8pTB75g=
Received: by 10.82.172.15 with SMTP id u15mr3179200bue.1169324485084;
        Sat, 20 Jan 2007 12:21:25 -0800 (PST)
Received: by 10.78.183.8 with HTTP; Sat, 20 Jan 2007 12:21:25 -0800 (PST)
To: "Johannes Sixt" <johannes.sixt@telecom.at>
In-Reply-To: <200701202105.23861.johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37289>

Hi Johannes(s) and list,

I managed a compilation, and some commands work, some don't.
Up to the first git commit, all is find.

I need to invoke the commit through the git-commit actually,
"git commit" says it's not a valid git command. so bash is a
true need in this case, might not even work in pure win32
cmd.exe approach.

Furthermore, once the commit is in, "git log" and git-log
do not work. Same for git-whatchanged and git-diff.

I need to try with the specific versions you mentionned, but
it's a pretty good start :)

--
Christian
