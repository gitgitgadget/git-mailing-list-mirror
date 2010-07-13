From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [BUG] 'diff A...B' fails with multiple merge bases
Date: Mon, 12 Jul 2010 20:12:54 -0500
Message-ID: <AANLkTikCiJtnRlKTbhiSRe48aDY27QPvjrEyjiOGGRsl@mail.gmail.com>
References: <3BA20DF9B35F384F8B7395B001EC3FB36CF674AE@azsmsx507.amr.corp.intel.com> 
	<7vaapw8ehn.fsf@alter.siamese.dyndns.org> <7vocec6xlt.fsf@alter.siamese.dyndns.org> 
	<7viq4k6xea.fsf@alter.siamese.dyndns.org> <AANLkTinfo1QDguIbNgOt9w9V9xuJbhrCmusfe9g8fosm@mail.gmail.com> 
	<7vy6dg5hwl.fsf@alter.siamese.dyndns.org> <AANLkTilnl5sw4M5p8AdO_Z73zBWzlwcZ8hIcdGDXf6de@mail.gmail.com> 
	<7vpqys5het.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Pickens, James E" <james.e.pickens@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 03:13:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYU3k-0002Dy-M7
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 03:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005Ab0GMBNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 21:13:15 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39154 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057Ab0GMBNO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 21:13:14 -0400
Received: by gwj18 with SMTP id 18so2464788gwj.19
        for <git@vger.kernel.org>; Mon, 12 Jul 2010 18:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=mrKSURiuOvZoPIib4CS57VcP5EwcWaW8RUV0PVTrfFU=;
        b=Dpg4rfdMHfCKzgmsGwF1SBi7jxmuKGMnlvuI4HLZlRhl6MxYItRiz0tt77PdNxijtV
         0FjIGN6arqrWS1RBs0KAJFU+2PMmRLpsm1CY+9xrNv4PWe6xtR6G5pg47CCy2u7XHh+f
         hJFBMI1JOZs5Zrut3WT2v8CBcxAWt04vHb4jk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kQ4rUnM7XzSxktyIkF42tlS0w4Rw9oTTbNQU7B3BZ8+MirUz93i9N9A207DxJjDZ3N
         e1seZD0lJUikNBNQq4VDgXI+cfkCksBNMUW3/Z3E6zOFBA3TzCUpClvUhDYYsLVfMDuU
         dx/LTWiInGDpabsgDvcSi0va91S2+JeC0WpL0=
Received: by 10.150.218.18 with SMTP id q18mr6534828ybg.22.1278983594217; Mon, 
	12 Jul 2010 18:13:14 -0700 (PDT)
Received: by 10.150.93.19 with HTTP; Mon, 12 Jul 2010 18:12:54 -0700 (PDT)
In-Reply-To: <7vpqys5het.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150864>

Heya,

On Mon, Jul 12, 2010 at 19:55, Junio C Hamano <gitster@pobox.com> wrote:
> which obviously has to allow three commits.

Well, then say that. "too many arguments for a regular diff, please
specify at most two commits to diff against". Anyone trying to use
diff to show a merge diff likely knows to look for the --cc switch;
either way, it'd be better than "what do you mean?".

-- 
Cheers,

Sverre Rabbelier
