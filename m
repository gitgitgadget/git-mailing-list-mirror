From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Does git fast-import support deltas?
Date: Fri, 19 Apr 2013 00:44:35 -0500
Message-ID: <CAMP44s10-TcbG8jz1CtK+CAPfdJxNxFj-r0udhLJdQ1hNMzDtg@mail.gmail.com>
References: <323381594.20130414121834@gmail.com>
	<673219382.20130414124800@gmail.com>
	<20130414113351.GA1299@thyrsus.com>
	<1762779000.20130415215818@gmail.com>
	<20130418094326.GB11038@thyrsus.com>
	<1095757971.20130419092931@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 07:44:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT47w-0005r2-Ew
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 07:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294Ab3DSFoh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 01:44:37 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:54400 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab3DSFoh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 01:44:37 -0400
Received: by mail-la0-f45.google.com with SMTP id gw10so3209305lab.4
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 22:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=0XdNXv71RxjeB8cqlYor7IcykcsfXIiKdEazw0Ar/xY=;
        b=Xo90mArlfGeTHlmYv3a99q18LtnRtKD6jsn2DLJKbXbw6b/AtIk2IMd3HRFpSpw7me
         soJ6XGO0LFJFaMGVFZ4s49HWlz4HZ0KJDO+OjJeW1RfqVJUyZW8UQKirMOJTIKScfo8b
         /T+Ti7WLBjJEe6ivPXn8XKo31a4zCG3wEkXh0MlU1LJwYFOcDruBIUZkdX/XHe9BUUQY
         5Si5vjmHF/xLl4URHa92/rJuYmGOFay8sV9HsSI/NTPTJcxV4ieCPx4aw8TJKWAFm7d/
         bQHcd7X/dYIpQd5NpnQ7Vh0SnGysyO6k8B0w05C2OZR3FrxSx1Ag/JozClzf573UjPU1
         7bOw==
X-Received: by 10.112.163.6 with SMTP id ye6mr7224145lbb.59.1366350275122;
 Thu, 18 Apr 2013 22:44:35 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 18 Apr 2013 22:44:35 -0700 (PDT)
In-Reply-To: <1095757971.20130419092931@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221738>

On Fri, Apr 19, 2013 at 12:29 AM, Ilya Basin <basinilya@gmail.com> wrote:
> Hi list.
> Here's what I mean:
> 1) a created a git repo from a foreign source using git fast-import
> 2) new commits were added to the foreign source
>
> Can I create a fast-import input stream not containing the commits
> already existing in my git repo and import it?

Yes, see the --import-marks and --export-marks options. The stream has
to refer to the marks that were used int the previous run.

Cheers.

-- 
Felipe Contreras
