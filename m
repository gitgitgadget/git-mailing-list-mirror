From: Marius Ungureanu <marius.ungureanu@xamarin.com>
Subject: Re: [PATCH 2/2] add csharp userdiff tests
Date: Sun, 27 Apr 2014 20:11:30 +0300
Message-ID: <33F87557-C685-4338-9BFA-2391442CD7A1@xamarin.com>
References: <29F78086-81B4-481F-9051-FF3EEBA9BB08@xamarin.com> <535B5BFF.40002@kdbg.org> <97789B23-A375-46B1-99FD-A851A15C2D85@xamarin.com> <535BF1C0.7080204@kdbg.org> <1EA6F663-54DC-4665-A88C-8627F38B356E@xamarin.com> <535BFFEB.8040103@kdbg.org> <3A0D05C9-C222-463E-BCD4-CD38F216E352@xamarin.com> <535D2E0C.40101@kdbg.org>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 27 19:10:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeSb7-0002ZL-5J
	for gcvg-git-2@plane.gmane.org; Sun, 27 Apr 2014 19:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbaD0RKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2014 13:10:31 -0400
Received: from mail-ee0-f43.google.com ([74.125.83.43]:42114 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093AbaD0RK3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Apr 2014 13:10:29 -0400
Received: by mail-ee0-f43.google.com with SMTP id e53so4166007eek.2
        for <git@vger.kernel.org>; Sun, 27 Apr 2014 10:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xamarin.com; s=google;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PiT2EDx4oD2WqXAYvgVKwxcQ1Q+w/DTsobARrlOenno=;
        b=Y+GA422gBgOxFHZEz4hcD1qvtaol5+aM0vRT3EjwKPh8NE+OzppLF6v4FrioD7d+HB
         YLjD6l7sZR5e5IAWuRITTYsDEfOFJ3SoJKR14dXqqEC3s/oR4RofCM2Ehx9EbKMvmmLY
         TUUsuR4F6EPDkNjci1Q3eraN1/RZ4svGQ4oyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=PiT2EDx4oD2WqXAYvgVKwxcQ1Q+w/DTsobARrlOenno=;
        b=kHnEZ1Vd0Qeug66twllpMJ+sEBSbfYSjDsffntQOrLyTHt5voCVtHpRmCKCM1eCVsY
         qCIRrUTYVuqbEcD993wQtDdH6hAxBQC2kFtkq+qzhLWAe8AECRb3HkIKkHM2/X+ap7SO
         OF79XTnEzVa0eF77dADszFzW+zKuajw4LkaAMAKbufgIzJEZT4lTESXjK2DqprSfN0jB
         GT1mx88Fyv38/GU2AP8Oh3Z2BCcO2Ti5Dqp46cYLVQ0KtTgntjo0YQ/3/ssIzbX96aIj
         PNGBeNJdZrrRvrzSK2lIZeUieymrxLKwM9NBtImOi/BNnZ4k2k0zp49T4JhFpVsFSJNV
         v3Tw==
X-Gm-Message-State: ALoCoQnY5hRlleYnIuqEvGJiuIb0JdrD0GSqFfo/nfECWWhFGfltlmX2t7Sbim6VyXPOW/ouUn2k
X-Received: by 10.15.64.75 with SMTP id n51mr27026948eex.33.1398618627945;
        Sun, 27 Apr 2014 10:10:27 -0700 (PDT)
Received: from [192.168.1.101] ([188.26.30.123])
        by mx.google.com with ESMTPSA id q41sm43107706eez.7.2014.04.27.10.10.26
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Apr 2014 10:10:27 -0700 (PDT)
In-Reply-To: <535D2E0C.40101@kdbg.org>
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247207>


> You can mark a userdiff test case that demonstrates a breakage by
> including the work "broken" somewhere in the file. See
> http://www.repo.or.cz/w/alt-git.git/commitdiff/9cc444f0570b196f1c51664ce2de1d8e1dee6046
> -- Hannes

Would you like me to add tests first, then fix them? Or just like this?