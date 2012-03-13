From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Removing unmaintained scripts
Date: Tue, 13 Mar 2012 10:29:56 +0100
Message-ID: <87k42olugb.fsf@thomas.inf.ethz.ch>
References: <1331514446.3022.140.camel@deadeye>
	<20120312024948.GB4650@kroah.com> <20120312063027.GB8971@1wt.eu>
	<20120312064855.GB16820@burratino> <20120312085820.GA11569@1wt.eu>
	<20120312152004.GB9380@kroah.com>
	<7vfwddu60f.fsf@alter.siamese.dyndns.org>
	<20120312171257.GA25347@kroah.com>
	<7vzkblsnos.fsf@alter.siamese.dyndns.org>
	<m38vj5zeo5.fsf_-_@localhost.localdomain>
	<20120312214139.GA11362@burratino>
	<loom.20120313T102017-876@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Sergio <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 10:30:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7O3Z-00023K-Hy
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 10:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023Ab2CMJaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Mar 2012 05:30:01 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:16851 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965008Ab2CMJaA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2012 05:30:00 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 13 Mar
 2012 10:29:55 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 13 Mar
 2012 10:29:56 +0100
In-Reply-To: <loom.20120313T102017-876@post.gmane.org> (Sergio's message of
	"Tue, 13 Mar 2012 09:23:34 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192990>

Sergio <sergio.callegari@gmail.com> writes:

> Jonathan Nieder <jrnieder <at> gmail.com> writes:
>
>> > A'propos, there is git-archimport script, last modified (as an
>> > individual script) in 2007.  Is anyone using GNU arch nowadays;
>> > isn't arch-fast-export better solution anyway?
>
> please do not remove the ability to convert arch/tla repos unless it is a real
> cost to maintain the scripts. There may be few people who still use arch, but
> there may be a lot of them who have arch repos of quiescent stuff that one day
> they may need to revitalize.

Perhaps it would be a good idea to add a test to ensure that
git-archimport doesn't suddenly break with nobody noticing for months.
Can you contribute a reasonable (small but representative) test repo?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
