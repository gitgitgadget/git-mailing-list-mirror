From: Junio C Hamano <gitster@pobox.com>
Subject: Re: (beginner) git rm
Date: Wed, 28 Jan 2009 13:29:36 -0800
Message-ID: <7vab9bm85b.fsf@gitster.siamese.dyndns.org>
References: <1233137498146-2231416.post@n2.nabble.com>
 <Pine.LNX.4.64.0901281133380.645@ds9.cixit.se>
 <1233140751523-2231622.post@n2.nabble.com> <49804385.908@dbservice.com>
 <1233144045221-2231849.post@n2.nabble.com> <49804D41.3010801@dbservice.com>
 <1233166992184-2233892.post@n2.nabble.com>
 <20090128201727.GD7503@atjola.homenet>
 <1233175322729-2234796.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Zabre <427@free.fr>
X-From: git-owner@vger.kernel.org Wed Jan 28 22:31:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSI05-00031R-Lr
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 22:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbZA1V3o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jan 2009 16:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbZA1V3o
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 16:29:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbZA1V3n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jan 2009 16:29:43 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D407A1D80F;
	Wed, 28 Jan 2009 16:29:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0D9E51D80E; Wed,
 28 Jan 2009 16:29:38 -0500 (EST)
In-Reply-To: <1233175322729-2234796.post@n2.nabble.com> (427@free.fr's
 message of "Wed, 28 Jan 2009 12:42:02 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C63F1E96-ED82-11DD-8DE3-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107578>

Zabre <427@free.fr> writes:

> Bj=C3=B6rn Steinbrink wrote:
>>=20
>> The "git checkout -- d.txt" is also a valid command, but that restor=
es
>> the file from the index.
>>=20
>> git checkout -- paths
>> 	=3D=3D> Copy "paths" from the index to the working tree
>>=20
>> git checkout <tree-ish> -- paths
>> 	=3D=3D> Copy "paths" from the tree-ish to the index and working tre=
e
>>=20
>> So, for "rm d.txt", a plain "git checkout -- d.txt" would also do th=
e
>> trick, as d.txt is still in the index. But your "git rm d.txt" also
>> removed the file from the index, and thus that checkout does nothing=
=2E
>> But "git checkout HEAD -- d.txt" works, as it gets the file from HEA=
D
>> and puts it into the index and working tree.
>
> This is enlightening, thank you very much!
> (I knew I would love git more and more)
>
> Oh just one (probably stupid) thing : <tree-ish> does represent a dir=
ectory
> being the root of a tree of folders (which has been added to the inde=
x),
> does it?

Yeah, it typically is a commit object.

Bj=C3=B6rn said "Copy", but the operation really is like checking out a=
 book
from a library and "checkout" is a good word for it.  "I do not like wh=
at
I have in my work tree, and I'd like to replace it with a fresh one tak=
en
out of the index (or, out of that commit)".
