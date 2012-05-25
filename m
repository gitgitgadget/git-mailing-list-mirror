From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of
 ~/.gitconfig
Date: Fri, 25 May 2012 11:34:57 -0700
Message-ID: <7vsjeortwu.fsf@alter.siamese.dyndns.org>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr> <CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com> <7v4nr4t9gc.fsf@alter.siamese.dyndns.org> <20120525182558.GC4491@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 25 20:35:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXzLz-0002fy-Iq
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 20:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756884Ab2EYSfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 14:35:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52134 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932083Ab2EYSfA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 14:35:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F3D98C58;
	Fri, 25 May 2012 14:34:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9jTnb3QR5eF3XSaQvEXYWjfgOrI=; b=LYrECv
	SCgk8RR3ihGuDrwKM6K9Y/xlnqNY/XmXD3JxNyOQPM+pBBlk5G3KYKVqu1yKwGAK
	OTYtzMdfsWPc2L1QwOCZdnlHSCXvNNAGPvBD1MJXple3K55yfmOd8WDxUE+hJOJc
	tzOtZosmy0dAxUHPMsxVzl1B9n/uZseB9XUco=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kNq4KZszu4qicPdcfimXOy8eC8XB1whr
	HZj+FRYQxGWeIW+ZaGhQsJl63+aiuDEbbFwngbnbJuIb/8jgvknE2wbzO0pwpd3k
	TMC+CrMwW3UPXM41HAjT9pUyaJ4RbMncUG2AKHIbz853oQcT23p9vCheeCxhEWCq
	sDeR6D9Faaw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1535D8C56;
	Fri, 25 May 2012 14:34:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C8EA8C55; Fri, 25 May 2012
 14:34:58 -0400 (EDT)
In-Reply-To: <20120525182558.GC4491@burratino> (Jonathan Nieder's message of
 "Fri, 25 May 2012 13:25:58 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54DC3216-A698-11E1-8261-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198504>

Jonathan Nieder <jrnieder@gmail.com> writes:

> If I understand correctly, the proposal that started this thread was
> to give people a chance to tidy their HOME directory by moving
> personal git configuration under ~/.config/git/.  

So it is exactly "I do not want ~/.gitconfig, I want ~/.config/git", no?

That is something distro should be able to decide.
