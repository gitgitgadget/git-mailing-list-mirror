From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-clone: Add option --branch to override initial
 branch
Date: Mon, 02 Mar 2009 16:09:38 -0800
Message-ID: <7vk577lb5p.fsf@gitster.siamese.dyndns.org>
References: <1236031882-2052-1-git-send-email-torarnv@gmail.com>
 <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tor Arne =?utf-8?Q?Vestb=C3=B8?= <torarnv@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 03 01:11:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeIEC-0003xB-Ak
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 01:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910AbZCCAJu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Mar 2009 19:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753289AbZCCAJu
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 19:09:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64363 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbZCCAJt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2009 19:09:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D7B03285D;
	Mon,  2 Mar 2009 19:09:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 23A592857; Mon, 
 2 Mar 2009 19:09:41 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 3 Mar 2009 00:48:56 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9AEA9EC2-0787-11DE-AE6B-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111979>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 2 Mar 2009, Tor Arne Vestb=C3=B8 wrote:
>
>> The options --branch and -b allow the user to override the initial=20
>> branch created and checked out by git-clone. Normally this is the ac=
tive=20
>> branch of the remote repository, which is also the fallback if the=20
>> selected branch is not found.
>
> I do not think that falling back if the selected branch is not found =
is a=20
> wise choice.
>
> Besides, the common way to check out something different than the rem=
ote's=20
> HEAD is like this:
>
> 	$ git clone -n $URL
> 	$ cd $DIR
> 	$ git checkout -t origin/$BRANCH
>
> I am undecided if that is good enough, or your patch is needed.

I am fairly negative on this one, if it matters.
