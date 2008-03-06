From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v3 3/4] git-submodule: New subcommand 'summary' (3) - limit summary size
Date: Thu, 6 Mar 2008 10:24:45 +0800
Message-ID: <46dff0320803051824t75f39524uda9bc864a9fe4435@mail.gmail.com>
References: <1204481710-29791-1-git-send-email-pkufranky@gmail.com>
	 <1204481710-29791-3-git-send-email-pkufranky@gmail.com>
	 <7v7iggitsd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 03:25:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX5nU-0000z7-E0
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 03:25:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757384AbYCFCYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 21:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752481AbYCFCYu
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 21:24:50 -0500
Received: from hs-out-0708.google.com ([64.233.178.243]:23172 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756625AbYCFCYu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 21:24:50 -0500
Received: by hs-out-0708.google.com with SMTP id 4so6409396hsl.5
        for <git@vger.kernel.org>; Wed, 05 Mar 2008 18:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5rjGCHdt/IdLOhFgj2NeMc3bhSCRCbzvuLBAV+RhUB4=;
        b=ZaMFeV89og3+E269G5NfjHTbVuDg7JPjCRlWqDs60TI+f9tJ6NSLiguBBcdZox5ltJK9IOs/qiv/0pAS5Rc7qrdujwRmKumnekolYmlpsqSE7xBFnOqZY4i11P8du/eKu95ufb7TK2/cgixX6eaURX2wE5oNJbGZLLbalPTX+/c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=yBu2yxX4vUaF8tv5zv17e2s0tFiW7h7b4RvB1jxtqVwPu6TpFCgar4NJfViv+o9l6yae0GIMTc+6QIY+gQuJoKkNVvomtE/5ytu2rRhhDa0uvZuhLG3LLHAH5hVHMs8MRV/LNvSwoRpf1WdT2d4buLZZiiQz+tK/fik8/6FYbko=
Received: by 10.101.71.16 with SMTP id y16mr8548886ank.66.1204770285841;
        Wed, 05 Mar 2008 18:24:45 -0800 (PST)
Received: by 10.100.5.18 with HTTP; Wed, 5 Mar 2008 18:24:45 -0800 (PST)
In-Reply-To: <7v7iggitsd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76310>

On Thu, Mar 6, 2008 at 8:24 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ping Yin <pkufranky@gmail.com> writes:
>
>  > This patch teaches git-submodule an option '--summary-limit|-n <number>'
>  > to limit number of commits in total for the summary. Number 0 will disable
>  > summary and minus number means unlimted (the default).
>
>  I really doubt showing the bottom one specially makes sense.
>
>  Why not just read from
>
>         git log '--pretty=%m %h %s' --left-right --topo-order A...B
>
>  and show N top commits from each?
I don't have strong point about this. This one sounds fine to me and
will make my patch much simpler.

>
>  I've already said that I do not think applying the same limit to
>  new/deleted/modified cases makes sense, so commenting on this
>  part might be a moot point, though.
>

Howabout a new option to limit the added/deleted case which default to 1 or 2?



-- 
Ping Yin
