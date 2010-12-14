From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 14/19] Convert ce_path_match() use to match_pathspec()
Date: Tue, 14 Dec 2010 22:14:55 +0700
Message-ID: <AANLkTikPKEPX48S=j7SU+T+6XkP1qKFgotvw42af3jRY@mail.gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-15-git-send-email-pclouds@gmail.com> <7vsjy1zcyg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 16:15:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSWbD-0005Mx-Lr
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 16:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759346Ab0LNPP2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 10:15:28 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:54634 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545Ab0LNPP1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 10:15:27 -0500
Received: by wyb28 with SMTP id 28so560602wyb.19
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 07:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ofZ/Qhk0+o0tgGSV/QUpG5XfVEm8E1cDI/dmRrvQfs8=;
        b=RzSS2ZmZsUxzdej2/VuD6hrsxG5u0Sidy1yyFchc/xkW/K2M9O/NCVtwGZItiIB3UZ
         NHPclNrdbzVWV4cTRh4ugpgzFB2Gh4y/47szwE8tu+CgCJBt2NfUvXU0TiTmWdIs/FGi
         PMG6Lagscexxe33LK/rGacm2FRor0JyNYZdKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KawnSyuWaV/qobntOLSrQ1QHce1Dh6eQIpkr0qp0UEr+ZKliax+6xACY4KZO/9cwJX
         CuG9EnsVrN25I8CohBEgme2ntV3wxdLnjPhxrWN5la2GjbehMdBPWSe6l4wtW/+1oQeF
         PtyWVXRQ/kQrf26EAbCjI0nI91u9UM/rKhkj4=
Received: by 10.216.169.71 with SMTP id m49mr6155065wel.4.1292339725911; Tue,
 14 Dec 2010 07:15:25 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Tue, 14 Dec 2010 07:14:55 -0800 (PST)
In-Reply-To: <7vsjy1zcyg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163653>

2010/12/14 Junio C Hamano <gitster@pobox.com>:
> I imagine that eventually ce_path_match() will also take "struct path=
spec *"
> not "const char **" when the series is completed, yes? =C2=A0Or there=
 is no
> real need for that?

But I do have the patches to convert ce_path_match to struct
pathspec*. Hmm.. I did. Need to look into reflogs..
--=20
Duy
