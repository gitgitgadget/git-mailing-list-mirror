From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Use cases for 'git statistics'
Date: Fri, 16 May 2008 17:02:19 -0700
Message-ID: <7vlk29er1w.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0805080851y2065bedfsf0f388cfd6d85929@mail.gmail.com>
 <200805121440.12836.jnareb@gmail.com>
 <bd6139dc0805120604m349b1fbbr39c6dcb8d893e771@mail.gmail.com>
 <200805131507.04912.jnareb@gmail.com>
 <bd6139dc0805130637saf704e1v2ab67c99da3078c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Sverre Rabbelier" <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 02:03:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx9tQ-0003Yj-N6
	for gcvg-git-2@gmane.org; Sat, 17 May 2008 02:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbYEQACb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 20:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753137AbYEQACb
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 20:02:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbYEQACa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 20:02:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E031B5662;
	Fri, 16 May 2008 20:02:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 18C6D5660; Fri, 16 May 2008 20:02:21 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8979EA3E-23A4-11DD-BEDF-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82321>

"Sverre Rabbelier" <srabbelier@gmail.com> writes:

>>  >>  Details I think need to be provided by maintainer...
>>  >
>>  > Do you mean Junio, or the user of the program?
>>
>>  I mean that all I can provide is speculation.  I'm not, and never was
>>  a maintainer of OSS project, and I don't know what criteria one use
>>  (perhaps unvoiced criteria) to decide whether given patch needs to be
>>  examined more closely, or the cursory browsing should be enough.
>
> I reckon more input from actual maintainers would be needed then.
> Junio: aside from the original list with suggestions you provided,
> could you shine your light as git maintainer on this?

A cursory browsing is enough only when you trust the contributor well.
For example, I read patches from Nico to code around the pack generation
only once or at most twice before I apply them, and the same thing can be
said about git-svn patches from or acked-by Eric.  These come mostly from
the fact that (1) I know they know the area a lot better than myself do,
and more importantly that (2) I know they care deeply about the subsystem
they are modifying, and they have good taste.

Project maintainers and old timers become familiar with habits, strengths
and weaknesses of known contributors over time, and that is the source of
such trust.

A clever enough automated way may be able to identify links between the
contributors and the areas they are familiar with, and using such a
mechanism people might be able to decide that a patch falls into category
(1) above.  I am not sure if any automated way could ever decide if a
patch falls into category (2) above, though.
