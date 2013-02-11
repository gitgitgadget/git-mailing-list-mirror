From: Ethan Reesor <firelizzard@gmail.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive shell
Date: Mon, 11 Feb 2013 02:26:02 -0500
Message-ID: <CAE_TNin+WcPodGfXKQuzBVujK7Yx3iCUR2rqgoc20WgwhJSR4g@mail.gmail.com>
References: <20130210212538.GA11720@elie.Belkin> <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org> <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin> <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin> <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin> <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
 <20130211061442.GI15329@elie.Belkin> <7vliavpc4q.fsf@alter.siamese.dyndns.org>
 <CAE_TNi=EG6vziVObJ-a__smeOv7RgZ5R146eonD6M828H7ziNQ@mail.gmail.com> <7v4nhjpb69.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:26:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4nmp-0004XZ-Ov
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 08:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685Ab3BKH0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 02:26:23 -0500
Received: from mail-qe0-f48.google.com ([209.85.128.48]:49407 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595Ab3BKH0W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 02:26:22 -0500
Received: by mail-qe0-f48.google.com with SMTP id 3so2410280qea.21
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 23:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+bx5znk4tX7YQf2o8dblbbJ7/oi1ne+9e+Mcf0lShFQ=;
        b=KIVQJXuYFdH4bpYZ/D6GVQLYoIwm0RR1zv/6rgFHzLLQGA00sdTZweGjyFJaaf53W4
         1Of6tRUZNFgwIVjZjaQlCCq/Ev3VYkG/hwD2JRSRxYuxMyV37evRdlcD53aq3sZdlebj
         d2LMGb6nCJ3ITEAVtBJVtCrQjvLJDMMB2que/40GEbee9QzLugXoA5ncRaAUeJ73NHzo
         eH9fCl4fbu9mwN/iJ9J0y09OjPpKgGdl1AIbzDuhHnO9gDQ4T2Ava2/Ku76qiNUft/Ae
         C8Gwx7kdiyL9nG5ihTlZWgWWVDS6H0U9IGY+T32a0j7E80zYKznspcvzx7oAY51Kh9uY
         0R9w==
X-Received: by 10.224.210.135 with SMTP id gk7mr5139462qab.57.1360567582144;
 Sun, 10 Feb 2013 23:26:22 -0800 (PST)
Received: by 10.49.95.225 with HTTP; Sun, 10 Feb 2013 23:26:02 -0800 (PST)
In-Reply-To: <7v4nhjpb69.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216016>

On Mon, Feb 11, 2013 at 2:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Ethan Reesor <firelizzard@gmail.com> writes:
>> Again, would it not be more elegant and powerful to A) have the
>> shell-disabled message/hook/etc specified by git-config on some level,
>> be it /etc/gitconfig or ~/.gitconfig, and B) have Jonathan's patch
>> whereby ~/git-shell-commands/help returning non-zero closes the
>> connection?
>
> Isn't that what I have essentially been saying?

That is what you've been saying. I reiterated because I like the idea
of having it managed via git config.
