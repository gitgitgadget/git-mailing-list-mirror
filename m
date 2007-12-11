From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 6/5] Move fetch_ref from http-push.c and http-walker.c
	to http.c
Date: Tue, 11 Dec 2007 08:49:31 +0100
Organization: glandium.org
Message-ID: <20071211074931.GB12959@glandium.org>
References: <1197322571-25023-5-git-send-email-mh@glandium.org> <1197328105-4843-1-git-send-email-mh@glandium.org> <7vve75hl72.fsf@gitster.siamese.dyndns.org> <20071211062129.GA8372@glandium.org> <475E3AA0.5010901@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Dec 11 08:50:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1zsK-00089u-Jl
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 08:49:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbXLKHtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 02:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751984AbXLKHtf
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 02:49:35 -0500
Received: from smtp20.orange.fr ([193.252.22.29]:22549 "EHLO smtp20.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751832AbXLKHte (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 02:49:34 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2013.orange.fr (SMTP Server) with ESMTP id BCFF81C000B4
	for <git@vger.kernel.org>; Tue, 11 Dec 2007 08:49:32 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2013.orange.fr (SMTP Server) with ESMTP id 9F3121C000AE;
	Tue, 11 Dec 2007 08:49:32 +0100 (CET)
X-ME-UUID: 20071211074932652.9F3121C000AE@mwinf2013.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1zrv-0003U8-TK; Tue, 11 Dec 2007 08:49:32 +0100
Content-Disposition: inline
In-Reply-To: <475E3AA0.5010901@op5.se>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67820>

On Tue, Dec 11, 2007 at 08:22:08AM +0100, Andreas Ericsson wrote:
> Mike Hommey wrote:
>> On Mon, Dec 10, 2007 at 09:09:05PM -0800, Junio C Hamano wrote:
>>> Mike Hommey <mh@glandium.org> writes:
>>>
>>>> Make the necessary changes to be ok with their difference, and rename the
>>>> function http_fetch_ref.
>>> Sorry, but I cannot parse "ok with their difference" part...
>>
>> What about "to fit with their difference" ?
>>
>
> Define "their" and "difference". Implicitly referring to another commit
> message won't help cursory glances much (and I have no idea what you're
> talking about since I didn't read the rest of your series very carefully).

The rest of the series doesn't have anything to do with this one, except
that fetch_ref had been modified to use strbuf in both.

Their difference is that one would take a ref with "refs/" at the
beginning and the other wouldn't. I'll try to write a better commit
message later today.

Mike
