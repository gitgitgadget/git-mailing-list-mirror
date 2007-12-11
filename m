From: Junio C Hamano <gitster@pobox.com>
Subject: Re: v1.5.4 plans
Date: Tue, 11 Dec 2007 11:13:29 -0800
Message-ID: <7vmyshdoyu.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
	<7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
	<7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
	<7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org>
	<1197386675.5001.4.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:14:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2AYY-0007fb-Lm
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752915AbXLKTNw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 14:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751960AbXLKTNw
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:13:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbXLKTNv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 14:13:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AB5B32FD5;
	Tue, 11 Dec 2007 14:13:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id F15D02FD4;
	Tue, 11 Dec 2007 14:13:41 -0500 (EST)
In-Reply-To: <1197386675.5001.4.camel@hinata.boston.redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Tue, 11 Dec 2007 10:24:35 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67908>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> On Mon, 2007-12-10 at 14:37 -0800, Junio C Hamano wrote:
>>  * We have a handful deprecation notices in the draft release notes,=
 but
>>    if I recall correctly, Nico wanted to add a few more.  We need to
>>    come up with a wording that is easy to understand for the end use=
rs
>>    to decide which ancient versions will be affected.
>
> Can we deprecate .git/branches?

We deprecated it from the very beginning, in the sense that we never
wrote into it ourselves, but merely tried to pay attention to what
others wrote there.  So I am open to a bullet point that officially
declares the deprecation.

But we need to come up with a removal schedule.  Say, the first feature
release after June 2008?
