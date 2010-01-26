From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git-format-patch should include a checksum
Date: Wed, 27 Jan 2010 00:26:44 +0100
Message-ID: <fabb9a1e1001261526tc86c04em4c6ede23e109e66@mail.gmail.com>
References: <871vhcmr5b.fsf@trurl.pps.jussieu.fr> <7vljfkxxj9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Juliusz Chroboczek <jch@pps.jussieu.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 00:27:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZuoR-0000Iw-TU
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 00:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392Ab0AZX1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 18:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110Ab0AZX1G
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 18:27:06 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:46027 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab0AZX1F (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 18:27:05 -0500
Received: by pxi12 with SMTP id 12so3914097pxi.33
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 15:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Ikm2Jid/sn04wR/3jiZBa1jNqeqr/TTEzwovs15gOEA=;
        b=FPpu9k3CT7QqTBg8cTy5lI06wo7ueh45PRUGqtKSt6Kt1oE2TUVRmilB7p/hJglCao
         QGEdUP7VCLViSOYaXRBjfHV3fV2HXRXykGea26ia3sFN7xmtYO5EC4jhuSphHG4EAdhl
         MOezBasIt5SallTU3LRR4m157vdhSyFcmLucs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ViEX4H80BNtKp7EVKDukTjU8bETSX2TRl4HtEF1RfP06vSkVx6ovaXRl/owxHjw4xr
         J/zVUvZNBagiEvMBEowatO7NCCF6R6Pry7/Duf6Qoy7E9PripIoCr0N255KaTLU3nkXk
         X3wVy5nydkEoEFgWQ2yFR37hfGY0NK26GaZlY=
Received: by 10.142.121.9 with SMTP id t9mr2393948wfc.144.1264548424238; Tue, 
	26 Jan 2010 15:27:04 -0800 (PST)
In-Reply-To: <7vljfkxxj9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138088>

Heya,

On Wed, Jan 27, 2010 at 00:21, Junio C Hamano <gitster@pobox.com> wrote:
> format-patch/am pair is designed to be lenient, allowing people to write
> additional messages after the three-dash lines after the output is made
> but before it is given to the MUA for sending the result out, for example,
> so adding a checksum over the entire output and forcing a check upon
> application is really a bad idea, even though, provided if the patch is
> done cleanly, it might be acceptable as an optional feature.

I would imagine that the checksum is taken over just the actual commit
message, perhaps author information, and use the patch-id for the
patch itself, that way any comments after triple dash would be ignored, right?

-- 
Cheers,

Sverre Rabbelier
