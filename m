From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Addremove equivalent
Date: Sat, 19 Jul 2008 20:27:44 -0700
Message-ID: <7vsku5grpr.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
 <7vmykhpn6z.fsf@gitster.siamese.dyndns.org>
 <20080717155538.GE11759@fieldses.org>
 <alpine.DEB.1.00.0807171915420.8986@racer>
 <7vtzeofjpi.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807171940160.8986@racer> <48806897.1080404@fastmail.fm>
 <76718490807181318o228171f9j836aaca2edb9b377@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: "Jay Soffian" <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 20 05:28:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKPbS-0007BB-B3
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 05:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297AbYGTD1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 23:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755295AbYGTD1y
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 23:27:54 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45235 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287AbYGTD1y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 23:27:54 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D08BB3347A;
	Sat, 19 Jul 2008 23:27:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 85C9C33478; Sat, 19 Jul 2008 23:27:46 -0400 (EDT)
In-Reply-To: <76718490807181318o228171f9j836aaca2edb9b377@mail.gmail.com>
 (Jay Soffian's message of "Fri, 18 Jul 2008 16:18:41 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D4F40960-560B-11DD-9335-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89153>

"Jay Soffian" <jaysoffian@gmail.com> writes:

> On Fri, Jul 18, 2008 at 5:55 AM, Michael J Gruber
> <michaeljgruber+gmane@fastmail.fm> wrote:
>> sometimes I find my self wanting an "addremove", such as in a situation like
>
> I have the following aliased as "addremove":
>
>   git ls-files -d -m -o -z --exclude-standard \
>   | xargs -0 git update-index --add --remove

I'll send out two patches on this topic.

Junio C Hamano (2):
      builtin-add.c: restructure the code for maintainability
      git-add -a: add all files
