From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Stamp Git commit id into file during build process
Date: Sat, 16 Jan 2010 20:29:28 +0100
Message-ID: <fabb9a1e1001161129j12c79a2dq21557938d4cf973c@mail.gmail.com>
References: <a1138db31001161050i73eade1bif968ca1256dcef2c@mail.gmail.com> 
	<40aa078e1001161114w5a65bebbhaf43317634899925@mail.gmail.com> 
	<fabb9a1e1001161117t6d572024yc5598be1b32ffcde@mail.gmail.com> 
	<40aa078e1001161122k48f55807y3f01fa0d38e5cc93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Richards <paul.richards@gmail.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 16 20:29:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWELK-00005B-Qx
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 20:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451Ab0APT3u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 14:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211Ab0APT3u
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 14:29:50 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:54441 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932182Ab0APT3t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 14:29:49 -0500
Received: by pxi12 with SMTP id 12so1942513pxi.33
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 11:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=K16+ENcjpo9Kq5JsUYN1Qwzq8xdEwdNzUCjurcPFPGA=;
        b=lD7wO3OyPv2CDFW55yyWzKhsRCBxCxs2HsXHYEWq5/cRtKV+TdXo+GCKHF1kLBb3k4
         4lSm1RQDHaDnohcP1GYwyJAZ/ByT2GE6W5kPBn6hsG3YEwinFF+Fa3/aR7xHj76VXkdV
         2lpfWWdtIQgwvvUW0jYFpoSk9H0cMYlhdULoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=PlsCk5+GDrUF0KukIw6tapNvLRaQt/JS/MJ1vjGZhXg5Ei8VbNYq5RWW+BmXd0r6AF
         Rh7bh519a6dKnvYJOh8aY6c8e42Q64jf9aaPc23jP2AvZKzQVNR0A+3kadBrhOCEfpP6
         dgX5jE1nxvmX0u2DxZ/Eks6CUtcLEQ6/AejJA=
Received: by 10.142.195.18 with SMTP id s18mr2764859wff.263.1263670188952; 
	Sat, 16 Jan 2010 11:29:48 -0800 (PST)
In-Reply-To: <40aa078e1001161122k48f55807y3f01fa0d38e5cc93@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137255>

Heya,

On Sat, Jan 16, 2010 at 20:22, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
> Since he's looking for a replacement for SubWCRev (as opposed to
> svn:keywords); not really.

I misunderstood then, since he mentioned 'git log' and you mentioned
'git rev-parse HEAD', and I do not know what SubWCRev does.

-- 
Cheers,

Sverre Rabbelier
