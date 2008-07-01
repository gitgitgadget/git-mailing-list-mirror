From: "Clifford Caoile" <piyo@users.sourceforge.net>
Subject: Re: How to reduce remaining differences to 4msysgit? (was
 What's cooking in git.git (topics))
Date: Tue, 1 Jul 2008 09:03:54 +0900
Message-ID: <1f748ec60806301703g134b8127i1965377adf9f04e5@mail.gmail.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org> <7v3amv1e8n.fsf@gitster.siamese.dyndns.org> <4CE52307-A2DE-488B-998B-76D60B66E804@zib.de> <200806302047.56935.johannes.sixt@telecom.at>
Reply-To: piyo@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: prohaska@zib.de, msysGit <msysgit@googlegroups.com>,  "Junio C Hamano" <gitster@pobox.com>,  "Git Mailing List" <git@vger.kernel.org>
To: johannes.sixt@telecom.at
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Tue Jul 01 02:04:58 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from wa-out-0708.google.com ([209.85.146.251])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDTMd-0006yy-Iq
	for gcvm-msysgit@m.gmane.org; Tue, 01 Jul 2008 02:04:58 +0200
Received: by wa-out-0708.google.com with SMTP id n36so5346764wag.21
        for <gcvm-msysgit@m.gmane.org>; Mon, 30 Jun 2008 17:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :dkim-signature:domainkey-signature:received:received:message-id
         :date:from:reply-to:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:sender:precedence:x-google-loop:mailing-list:list-id
         :list-post:list-help:list-unsubscribe:x-beenthere;
        bh=n+30X2aMiLvVKt+i7p3wInRj7VGH0D1aUv534FzEDws=;
        b=gl1bprFYH5QDNGGIX7/6Za48RLgIk8WSfpOEXHMkkEou3jS32rUhQI2rDEEpVJQ4rR
         QrDFiDkqKTUTMcgOY21hfYzTkzSlqr00XVpEKERY/XMXtG+xayO99fMU7Br/3/S7Yy95
         06ZyxLfYYPv/ynPNaGB4wx2Vr642kXjetH24c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:message-id:date:from:reply-to:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references:sender
         :precedence:x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        b=t35SCpCpYKwZwskfDVM0chO8YHpBg1JH0IOU3ldR/shgM+T5QOYU9fIngEyEyR9gNS
         xEpTAtmaJGXDEKWBLzhEp+Oek31tV1YQyrA+UgE+mBw/RjTV8EZGpQg8JPhhlboxZUtk
         fnsu76ft5b7CLfz1sXb9HqTEv9G1xeiLzAy/0=
Received: by 10.141.164.4 with SMTP id r4mr369537rvo.1.1214870635959;
        Mon, 30 Jun 2008 17:03:55 -0700 (PDT)
Received: by 10.106.234.8 with SMTP id g8gr2530prh.0;
	Mon, 30 Jun 2008 17:03:55 -0700 (PDT)
X-Sender: piyokun@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.141.3.17 with SMTP id f17mr160929rvi.24.1214870635443; Mon, 30 Jun 2008 17:03:55 -0700 (PDT)
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250]) by mx.google.com with ESMTP id 7si6005859yxg.1.2008.06.30.17.03.54; Mon, 30 Jun 2008 17:03:55 -0700 (PDT)
Received-SPF: pass (google.com: domain of piyokun@gmail.com designates 209.85.132.250 as permitted sender) client-ip=209.85.132.250;
Authentication-Results: mx.google.com; spf=pass (google.com: domain of piyokun@gmail.com designates 209.85.132.250 as permitted sender) smtp.mail=piyokun@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by an-out-0708.google.com with SMTP id c35so300882anc.44 for <msysgit@googlegroups.com>; Mon, 30 Jun 2008 17:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:message-id:date:from:reply-to :sender:to:subject:cc:in-reply-to:mime-version:content-type :content-transfer-encoding:content-disposition:references :x-google-sender-auth; bh=No7eSG5nPf7SYdx6cCEtYMZlIO9N1kreMHlZiSk7Uss=; b=PbX4sv1yCxkikJ+0c0uQbBFdM5newH2jQnkq8lqC2MgvA/syVGaJl+B3krOPBOWEd0 +c97zIdiFUQg45ZUCsXPdCgyTURP5ZXqHYEFvRBVJabAP5kQJde/6HLxOtHgNOr7iqMn w3eV70LmStCF5/Pd2JzM8hKNnsvIOIpW1jRsE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to :mime-version:content-type:content-transfer-encoding :content-disposition:references:x-google-sender-auth; b=xeLyns+hrC43m6hNs40nhjGmzwqgZsAl8LyopJeUs/nOsSoQrNtBa0z+jOKmI/W/tf VpGwSYZq/aserEz4KyeLiY8rUZ/7OlDJPvpzgM4kFhZhGwS+QnwoaJJUCjsVmidLtZmd i2gApXrU5krsLgPXCr8xKsLPhTG8W1gmu1gY0=
Received: by 10.100.120.6 with SMTP id s6mr5017828anc.72.1214870634252; Mon, 30 Jun 2008 17:03:54 -0700 (PDT)
Received: by 10.100.227.15 with HTTP; Mon, 30 Jun 2008 17:03:54 -0700 (PDT)
In-Reply-To: <200806302047.56935.johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86974>


Hi:

On Tue, Jul 1, 2008 at 3:47 AM, Johannes Sixt <johannes.sixt@telecom.at> wrote:
>
> On Montag, 30. Juni 2008, Steffen Prohaska wrote:
>> On Jun 30, 2008, at 11:08 AM, Junio C Hamano wrote:
>> > * MinGW will be in.
>>
>> How should we proceed to get rid of the differences?
> ...
> Then there are the extra patches in 4msysgit. From my POV, they are not
> _required_ because I can appearently work with git on Windows without them. I
> think some of them are not necessary. Can we go through them again?

As one of the extra patches in 4msysgit, there is the cca/git.el
branch [1] which I contributed [2] previously for Emacs git.el users
on Windows. However I have not gotten any feedback whatsoever, so
perhaps parking it in 4msysgit is not appropriate. I plan to
separately to host these patch(es). Please ignore it or remove it at
your convenience.

References:
[1] http://repo.or.cz/w/git/mingw/4msysgit.git?a=shortlog;h=refs/heads/cca/git.el
[2] http://thread.gmane.org/gmane.comp.version-control.msysgit/2140

Best regards,
Clifford Caoile
