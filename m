From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of
 ~/.gitconfig
Date: Fri, 25 May 2012 11:20:47 -0700
Message-ID: <7vwr40rukg.fsf@alter.siamese.dyndns.org>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr> <CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com> <20120525174237.GA4267@burratino> <CAE1pOi3qSEY=Dj-Fqj+=anULVmCdsm72_k+B0SpdGiCO3u7L9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, nguyenhu@minatec.inpg.fr,
	git@vger.kernel.org, matthieu.moy@grenoble-inp.fr,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 20:21:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXz8S-00075s-Pr
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 20:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192Ab2EYSUv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 May 2012 14:20:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45719 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932083Ab2EYSUu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2012 14:20:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3867787D7;
	Fri, 25 May 2012 14:20:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JhTrp8/IBlH1
	k8Dadz/O6+3nJRE=; b=CwcEc06ZKbohiMAT3b8ZRZSgBZh3fwNnVjn1K8deJmqR
	J88ZCl3MYIlWOgABsCSNsGPJfbGwYirdCkyYPpQVZDChiozyXrJLohsTS7nuiptW
	NR9OH4Tj8V46BdS+tvvny9LPoQ0HxpVk1YJu2mdz4pF/3if4LTnQ9fPRiYAyJ7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=P4vq8E
	ktOM9qBZWOCuU/IrMc1BXdbhVXpD2Yz6FCvkJw0rajUZY0aZv0zZvaYq+YevVNeG
	M7IocwERveQUHNOIUT9AcHnHsTaCzn5/auBXmC40zwDzs/bp58thXm7xpNk+PLa9
	/zBmjuZOKovQMqbT2K8tFc0DkmF1r77gwH5I0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 246A887D5;
	Fri, 25 May 2012 14:20:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C35CA87D1; Fri, 25 May 2012
 14:20:48 -0400 (EDT)
In-Reply-To: <CAE1pOi3qSEY=Dj-Fqj+=anULVmCdsm72_k+B0SpdGiCO3u7L9A@mail.gmail.com> (Hilco
 Wijbenga's message of "Fri, 25 May 2012 10:47:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A51B88A-A696-11E1-9196-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198502>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

>> Regarding $GIT_DIR/config, it says "The filename is of course relati=
ve
>> to the repository root, not the working directory.". =C2=A0Is this o=
ut of
>> date? =C2=A0(Cc-ing Peff and Duy.)

It is only worded awkwardly, I think.  The above is merely trying to sa=
y
that you do not place 'config' anywhere in the working tree; in other
words, "repository" in the above refers to GIT_DIR, and the "root" mean=
s
not inside refs/, objects/, or anywhere, just next to index, HEAD, etc.
