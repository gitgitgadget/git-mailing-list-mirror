From: Marius Ungureanu <marius.ungureanu@xamarin.com>
Subject: Re: [PATCH] Updated C# userdiff patterns.
Date: Sun, 27 Apr 2014 16:43:49 +0300
Message-ID: <241D6B37-A274-4425-868C-E15651132B24@xamarin.com>
References: <29F78086-81B4-481F-9051-FF3EEBA9BB08@xamarin.com> <535B5BFF.40002@kdbg.org> <97789B23-A375-46B1-99FD-A851A15C2D85@xamarin.com> <535BF1C0.7080204@kdbg.org> <1EA6F663-54DC-4665-A88C-8627F38B356E@xamarin.com> <535BFFEB.8040103@kdbg.org>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 15:43:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WePMf-0004nR-0l
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 15:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbaD0Nmw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Apr 2014 09:42:52 -0400
Received: from mail-ee0-f44.google.com ([74.125.83.44]:60746 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbaD0Nmv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Apr 2014 09:42:51 -0400
Received: by mail-ee0-f44.google.com with SMTP id e49so4015928eek.17
        for <git@vger.kernel.org>; Sun, 27 Apr 2014 06:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xamarin.com; s=google;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2/ZxlEUa8PtZmGvlwHSe7KI/j9smqTcePZfuprtB4tE=;
        b=pPfD5AoohrZfQBp3DvBP474GHXTBJc5v15PlG2yuqolVb6JGmB8osZwZtVVf3xtcA/
         QAJ8VTACkkvoabaJryBnRSB2UKUL+KryLjHx/l69w2c1lWHnPVP2zfe/o2ATBmOTTyhg
         LwZT/H5JVc++ZCgOuCP1wcIC2WNhVrU0ofs/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=2/ZxlEUa8PtZmGvlwHSe7KI/j9smqTcePZfuprtB4tE=;
        b=MRdXlPj3dhOq3LMP+Fopg04uJwuvFu3PaeXQEjv2oKrPMb4S9xthe9DFCYdAzmBPMb
         OXE7ZijbLGtfVpRfOgwVUcK8DdNnbey70yS2Q79Obs9FeD+iF7upseqi14I5u2/rXJ9m
         kjhMPsORxMnnlmmxKDLkp8IUxBJRfcBJJI9/gL93ydbpmD5rRNDrspNO6F4x25Qd5m8q
         Xd1oIZheK68ei1e9fdqBi5qJpsK/zal/vU7T6vvpdhl2xVC5le2gHhSoLKuoCVKkpvEs
         0NIGcLlY/XD/RtyO8qeoBMxEaGms6A2NOFrA5oodWvuVOkhLj7EQpDwN+PnwK1+WqB/W
         J3SA==
X-Gm-Message-State: ALoCoQlzhVmwO521iD8XcYSbqa+H1gnYEda+kQDAEEq/CNRHNzWpkgvR8dXbV1NfyzW6H82qYxNl
X-Received: by 10.14.225.73 with SMTP id y49mr25261703eep.43.1398606169617;
        Sun, 27 Apr 2014 06:42:49 -0700 (PDT)
Received: from [192.168.1.101] ([188.26.30.123])
        by mx.google.com with ESMTPSA id u46sm41809459eel.1.2014.04.27.06.42.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Apr 2014 06:42:48 -0700 (PDT)
In-Reply-To: <535BFFEB.8040103@kdbg.org>
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247200>

Heya, so I=92ll add the patches in the next 2 emails.

I=92ve changed a bit the main body of the methods/constructors regex.

Basically, I=92ve made the first item after the modifiers optional. Tha=
t=92s
the return type and it=92s not used in any case by operator overloads
or constructors/destructors.

I also added lots of symbols to the name of the function. Those are
the symbols of the operators that the language allows you to overload.

Thanks in advance,
Marius.