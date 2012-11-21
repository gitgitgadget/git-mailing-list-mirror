From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v5 11/15] remote-testgit: make clear the 'done' feature
Date: Wed, 21 Nov 2012 11:20:49 -0800
Message-ID: <CAGdFq_jy2WYE1i99V1gGWY8jc19CVGngf-VFXxDw3HJC3YD-pA@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-12-git-send-email-felipe.contreras@gmail.com>
 <29291552-880A-4FEB-88E0-A73A1C7742F7@quendi.de> <CAMP44s0o1eP+aeT0AHu4uP1NPLqJq56qUDb-+F_x5NjoJCnf+A@mail.gmail.com>
 <EA56F0CC-7C93-491F-A076-4A1AA9593ED0@quendi.de> <7vy5hu3h11.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:21:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbFrl-0000Tg-Rv
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:21:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755820Ab2KUTVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:21:31 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:49844 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768Ab2KUTVa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:21:30 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so5117150qcr.19
        for <git@vger.kernel.org>; Wed, 21 Nov 2012 11:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=460C+oEMRTnY7+qtOTtdUjYvFfKlpgC6PdtLGFjA7wA=;
        b=Go+MuprrwpFRLqfFwPXyFQJ/jz8ZqGrOl/6N0jSsy5rq8vXsvXX9NR18mlGVQ85NyP
         8is6yHBkAngbOw7Dd8OO7JvoHQ3b+K9LUtKy44zHxoc8+vgeaVN3LXmg9fPaAk5rQDV5
         +2eg/AIpyUrFY/6L6xhN0SjwDFG12IsjnsZPB/LEpwtwMyqu7V8rM68DsyQBJEbfJnJ7
         ljAXnorfZkq/rPOyMMFIkQ+opzftQOKLJvDhnV6yrNKVf6nf5APO25HO9xYS/0FQ1R2P
         8l9cSXvsg/plp7Qm/oVZ0qh1cIg1bgEVRQnot7UMLmZxfS+Lj6L/3M3RC9SWl6B6XB4b
         rbSw==
Received: by 10.224.182.203 with SMTP id cd11mr19512176qab.22.1353525689620;
 Wed, 21 Nov 2012 11:21:29 -0800 (PST)
Received: by 10.49.34.234 with HTTP; Wed, 21 Nov 2012 11:20:49 -0800 (PST)
In-Reply-To: <7vy5hu3h11.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210164>

On Wed, Nov 21, 2012 at 10:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> I'd state it like this, but I may have guessed what Felipe intended
> incorrectly.
>
>     remote-testgit: advertise "done" feature and write "done" ourselves
>
>     Instead of letting "fast-export" advertise the feature and ending
>     its stream with "done", do it ourselves.  This way, it would make it
>     more clear to people who want to write their own remote-helper to
>     produce fast-export streams without using "fast-export
>     --use-done-feature" that they are supposed to end their stream with
>     "done".

With that commit message:

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

-- 
Cheers,

Sverre Rabbelier
