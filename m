From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v3 5/7] i18n: am: mark more strings for translation
Date: Wed, 25 Jul 2012 08:38:26 +0200
Message-ID: <871uk0ny59.fsf@thomas.inf.ethz.ch>
References: <cover.1343112786.git.worldhello.net@gmail.com>
	<d3711733085d683d9a63cff6f615ef3114f2d3c0.1343112786.git.worldhello.net@gmail.com>
	<20120724181600.GH2939@burratino>
	<7vwr1sevpu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 08:38:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StvEy-0004tl-9O
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 08:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860Ab2GYGib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 02:38:31 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:59507 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256Ab2GYGia (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 02:38:30 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 25 Jul
 2012 08:38:26 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 25 Jul
 2012 08:38:27 +0200
In-Reply-To: <7vwr1sevpu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 24 Jul 2012 13:43:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202131>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Before this patch, it says
>>
>> 	The --binary option has been a no-op for a long time, and ...
>>
>> After the patch, it says
>>
>> 	The -b option has been a no-op for a long time, and ...
>>
>> Intentional?  That may be a good change or a bad one (I haven't
>> thought clearly about it), but it seems at least worth mentioning.
>> Cc-ing Thomas in case he has advice.
>
> If we really care we could printf $1, but I think we usually do
>
> 	The -b/--binary option has been...
>
> in a case like this, especially in codepaths that no longer has an
> easy access to $1 after parsing the command line but knows that
> either one of them is given from the parse result, and that would be
> an appropriate solution for this particular one as well.

Yes.  The original plan was to free up -b, but since we don't need
--binary any more either, it's better if we can get rid of it the same
way.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
