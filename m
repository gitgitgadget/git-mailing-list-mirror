From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCHv2 1/2] git-gui: respect conflict marker size
Date: Fri, 19 Nov 2010 12:48:17 +0100
Message-ID: <AANLkTimSU9RfFNpXi3u7BN+eFGBSOaPXS4OOfDmwYaDB@mail.gmail.com>
References: <1289893762-28567-1-git-send-email-bert.wesarg@googlemail.com>
	<1289899312-2732-1-git-send-email-bert.wesarg@googlemail.com>
	<87k4k9h858.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Shawn O . Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Nov 19 12:48:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJPS4-0004P8-Je
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 12:48:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129Ab0KSLsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 06:48:19 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61451 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257Ab0KSLsS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 06:48:18 -0500
Received: by wyb28 with SMTP id 28so4352987wyb.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 03:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=NdNXEO3tY/Sno3sCJ6uD6oa/Eughv5ZisFehMpXHsqs=;
        b=U42sUOk2UWOuA18PIwHnI2nKcQxuO/pmp1E9YIKvMtoN6XpBxrRJbNcAVsouYno07l
         gJomg8hC/9/AicG78Ip0pTtxavovD4hwUjp2YcPhCliiz4aPT9yg4QaqdVt1qGzbTlbf
         Cf4hT+GkL2Z2WRH16LOZ/rgejWahHLgMaPzbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ORQa5nIPRWBooQly5v11SeO9+0ajoXaF0LdHk+ipPx6htyyTJxiob6DY7AXwSsdLpI
         EA53qQI0cr8IBN7Q++MeGn3rwq1pCZ3VBfx0fKvIPu9JrApLX581mlRqr++voSE0Y6JH
         v6Z+dDLJqD+5V4/kOJ6lOWH9LMu4Mx+uvddD4=
Received: by 10.227.128.197 with SMTP id l5mr2162498wbs.22.1290167297295; Fri,
 19 Nov 2010 03:48:17 -0800 (PST)
Received: by 10.227.157.149 with HTTP; Fri, 19 Nov 2010 03:48:17 -0800 (PST)
In-Reply-To: <87k4k9h858.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161738>

On Fri, Nov 19, 2010 at 12:20, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> Tcl doesn't expand variables in curly-braced expressions so the
> $conflict_size is left in there verbatim.

I should have noticed it either by testing or by wondering why i
didn't need to escape the '$', which I have tested but with a verbatim
7 as the conflict_size in the regex.

Thanks for fixing.

Bert
