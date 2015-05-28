From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC 1/2] git-rebase -i: Add key word "drop" to remove a commit
Date: Thu, 28 May 2015 19:45:32 +0200
Message-ID: <vpqpp5ksiir.fsf@anie.imag.fr>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr>
	<c78cd2ac17333a2e70d1113d95495c41@www.dscho.org>
	<1506177855.44397.1432738386768.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpq1ti23vva.fsf@anie.imag.fr>
	<xmqqsiahltbu.fsf@gitster.dls.corp.google.com>
	<vpq8uc9yfdp.fsf@anie.imag.fr>
	<xmqq382hlpwt.fsf@gitster.dls.corp.google.com>
	<CAGZ79kansAUWsjBsBznqaxRFeN3uF1u2hUZgO8b+OjOw8SKsUw@mail.gmail.com>
	<f5ed9832bba0381314d01fba13e20667@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 28 19:45:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy1sK-0006ZR-T7
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 19:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbbE1Rpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 13:45:45 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35719 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184AbbE1Rpo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 13:45:44 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SHjUJu017631
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 May 2015 19:45:30 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t4SHjWrS016079;
	Thu, 28 May 2015 19:45:32 +0200
In-Reply-To: <f5ed9832bba0381314d01fba13e20667@www.dscho.org> (Johannes
	Schindelin's message of "Thu, 28 May 2015 19:06:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 28 May 2015 19:45:31 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t4SHjUJu017631
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1433439935.32925@wGmjCO9QWnRctSiELdLBGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270170>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Hi Stefan,
>
> On 2015-05-27 23:47, Stefan Beller wrote:
>> On Wed, May 27, 2015 at 1:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Talking about ideas:
>> I sometimes have the wrong branch checked out when doing a small
>> fixup commit. So I want to drop that patch from the current branch
>> and apply it to another branch. Maybe an instruction like
>> cherry-pick-to-branch-(and-do-not-apply-here) would help me there.
>
> Oh, is it wish-anything time? *claps-his-hands*
>
> I would wish for a graphical tool which visualizes the commit graph in
> a visually pleasing manner, where I can select one or more commits and
> drop them onto a commit in the graph, and then it goes and magically
> cherry-picks-and-drops them.

You need to argue a bit more to convince my students to schedule this
for the end of their projects ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
