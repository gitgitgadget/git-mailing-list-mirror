From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git subtree: an alternative to git submodule
Date: Mon, 18 May 2009 12:38:56 -0400
Message-ID: <32541b130905180938v5dd5283g6b75ffb7e76f3280@mail.gmail.com>
References: <1241822349-27470-1-git-send-email-apenwarr@gmail.com> 
	<32541b130905150909h7e596f26w7db6887e7f4267ff@mail.gmail.com> 
	<7vzldes0ce.fsf@alter.siamese.dyndns.org> <32541b130905151131h76048ff2o418764aa41bcd13b@mail.gmail.com> 
	<46dff0320905180855m3e1bd74esb564af0fbcf4b1ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 18:39:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M65s4-0004Km-Cc
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 18:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456AbZERQjQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2009 12:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752641AbZERQjP
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 12:39:15 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:61051 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbZERQjP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2009 12:39:15 -0400
Received: by gxk10 with SMTP id 10so6453575gxk.13
        for <git@vger.kernel.org>; Mon, 18 May 2009 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=EuVBGYfuw7sOxbzdug/B4AgNpnyO1C3iRvytT70sTa8=;
        b=oA/Z4FcqcJUTDaEHkRMt7yOLEmlmDSdwSB6WgUCpbnGbSWAQBkffqCgzUfSmt6DP5Z
         jBFxrLn83RfIpSBxl/i2A/vGsB7Sat2/dX5suj82YVPrtMCmqVrYAYmOpTdtfDY3s9VT
         3pLJ3/eRsXZLCJvbLbPtKSR1ha6RF3eq/vVUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uiBLoCurmrwFgxyuupfILjXQSMj25BVsOPP+L3oA9DzrojaRVf8Rol5Vzt5gH2Iip0
         sm2/RRJLboImPFDDneiEB8Rg71yAnxJxm49EFJM5+QSm0JOjLbMhULFIVP/579v0xZtS
         oCd8hJLSNYZUtzGacgr5LbdfFQ+LK+/sRjVh0=
Received: by 10.151.46.11 with SMTP id y11mr12914566ybj.325.1242664756104; 
	Mon, 18 May 2009 09:39:16 -0700 (PDT)
In-Reply-To: <46dff0320905180855m3e1bd74esb564af0fbcf4b1ff@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119457>

On Mon, May 18, 2009 at 11:55 AM, Ping Yin <pkufranky@gmail.com> wrote:
> It's really a cool feature, but i havn't tried it. Why?
>
> It will spends me some time saving and applying the patches and then
> testing it (i don't have the appropriate environment setuped). But I
> am busy and there is no urgent need to use this feature ( it is only =
a
> rare case for me). =A0So i will wait until i need the feature or ther=
e
> is an easy to fetch the code ( pu of official reposotory or other
> repository with these patches applied).

Excellent, thanks for the feedback.  In fact you can git clone the
code from here:

  git clone git://github.com/apenwarr/git-subtree.git

(It's not a copy of the git repo; it's a tiny standalone repo.)

The important file is 'git-subtree'.  Copy this anywhere on your PATH,
and magically the 'git subtree' command will work.

I admit that your next roadblock will probably be lack of
documentation, though, as Junio points out.

Have fun,

Avery
