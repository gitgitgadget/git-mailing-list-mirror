From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [RFC] test-lib.sh: No POSIXPERM for cygwin
Date: Wed, 6 Feb 2013 10:34:45 +0100
Message-ID: <CABPQNSYmGhaDG0Dzpp2C0ZwKoFwP5EokJW+TC8JT-Bw6rKa79A@mail.gmail.com>
References: <201301271557.08994.tboegi@web.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: ramsay@ramsay1.demon.co.uk, git@vger.kernel.org, j6t@kdbg.org
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 10:36:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U31QF-0002Ee-C5
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 10:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238Ab3BFJf3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Feb 2013 04:35:29 -0500
Received: from mail-ia0-f175.google.com ([209.85.210.175]:55956 "EHLO
	mail-ia0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab3BFJf0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2013 04:35:26 -0500
Received: by mail-ia0-f175.google.com with SMTP id r4so1296799iaj.6
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 01:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=R1A5rIW5Njf3g+LbWAE5epcaOfk9iUYJ2SK089f5RrI=;
        b=SdjfKne+HGUQbOSfp1CBayr1AI0krq4FVpA+IgV5Q1AHvq53Gq3oXP2aQaBnO4Kv9i
         yAGU+wFBenQjq/ev7DQG3AzoUb5tI0bBU3Zcyr/RSARx2XIZ3uLEgsyFp4IEKx4y4YiD
         hHkhZ87Z4d79+UNXhhws5EHUiTAJ+fHeg47pdAT41taSAW4qadhAk+QleQROgS1c37lL
         ezGsi2dCPEgcN66HSXtu2eveBqHP9ACzvl2ahWby+x5+j2rNOO0fiVUTC5HlsorOs9p3
         853YCl2mB9uwnbpRqvaSCPkQQWkUX3qKPBZ/qIhdcRoLHNWzc8Ii2Qdo/LurGvr6AhZI
         ga0A==
X-Received: by 10.42.215.196 with SMTP id hf4mr27574966icb.23.1360143326135;
 Wed, 06 Feb 2013 01:35:26 -0800 (PST)
Received: by 10.64.14.161 with HTTP; Wed, 6 Feb 2013 01:34:45 -0800 (PST)
In-Reply-To: <201301271557.08994.tboegi@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215568>

On Sun, Jan 27, 2013 at 3:57 PM, Torsten B=F6gershausen <tboegi@web.de>=
 wrote:
> t0070 and t1301 fail when running the test suite under cygwin.
> Skip the failing tests by unsetting POSIXPERM.
>

But is this the real reason? I thought Cygwin implemented POSIX permiss=
ions...?
