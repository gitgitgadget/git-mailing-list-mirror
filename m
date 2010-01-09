From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to push changes from clone back to master
Date: Fri, 08 Jan 2010 22:49:16 -0800
Message-ID: <7vhbqvdb83.fsf@alter.siamese.dyndns.org>
References: <1262986087967-4275010.post@n2.nabble.com>
 <4B47D52A.1050608@dbservice.com>
 <2394EBAE-BA99-4817-93E3-D5441D6DA46B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tomas Carnecky <tom@dbservice.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Simon Chu <simonchu.web@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 07:49:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTV8z-0004d4-7D
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 07:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187Ab0AIGt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 01:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135Ab0AIGt3
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 01:49:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46698 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070Ab0AIGt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 01:49:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 282C18F901;
	Sat,  9 Jan 2010 01:49:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=s/hzSRkYYBv7Aiwwkb5g2g8ZvcM=; b=EITiXa
	L2acg5zxjl/9nR8JjzDbe3LdnPasxddAeSEfwxb/pU9AxXgNuS/DMtjG++jmoTCb
	QiH+YK6Z0ZfZCddcDfAS3PG47Y1I6K2F+5k06VbRvISAuGWA/nfZRE/t+c1QZzRj
	FeqaQPXcg1235PKaiPzPkZYgMHOitA0eXm3Tc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sQu4QSqoG5cGZeVnr3r9Y0AT22yXMcfy
	+qpcukiJ/RGosKzrZn0v84TJp02CCF50hES7FSjYOr6UKk7TehwyvnlKaKqdKwx+
	OsBhZjHiCkcT2eh3UtI6b5gVcscxpxbYja8+3HIYa72SWm0Vlg9vHM+f4QRll017
	fZviivm0Xy8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6D3F8F900;
	Sat,  9 Jan 2010 01:49:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39DEB8F8FF; Sat,  9 Jan
 2010 01:49:19 -0500 (EST)
In-Reply-To: <2394EBAE-BA99-4817-93E3-D5441D6DA46B@gmail.com> (Simon Chu's
 message of "Fri\, 8 Jan 2010 21\:53\:49 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1EA24568-FCEB-11DE-9F3A-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136519>

Simon Chu <simonchu.web@gmail.com> writes:

> On Jan 8, 2010, at 5:00 PM, Tomas Carnecky <tom@dbservice.com> wrote:
>
>> If you asked that question in the official IRC channel, the answer
>> would be 'faq non-bare', which would cause the bot to send you a
>> link to this entry in the Git FAQ:
>> http://git.or.cz/gitwiki/GitFaq#Whywon.27tIseechangesintheremoterepoafter.22gitpush.22.3F
>
> How do I push code to master then, do I do got reset - hard on the
> master??

(Please do not top post).

If you asked that question on the IRC, the answer would be 'faq
mothership-satellite', which would cause the bot to send you a link to
this entry in the Git FAQ:

    push is reverse of fetch. See
    http://git.or.cz/gitwiki/GitFaq#mothership-satellite

This link is recommended by the entry Tomas gave you, so I am having this
sad feeling that you wouldn't read it either...  Sigh.
