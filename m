From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] merge hook tests: fix missing '&&' in test
Date: Tue, 18 Mar 2014 11:27:18 -0700
Message-ID: <xmqq4n2v9xbt.fsf@gitster.dls.corp.google.com>
References: <xmqqmwgoejwq.fsf@gitster.dls.corp.google.com>
	<1395136856-17225-1-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 19:27:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPyjY-0000al-DT
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 19:27:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757396AbaCRS1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 14:27:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61780 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757234AbaCRS1W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 14:27:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00EF77232F;
	Tue, 18 Mar 2014 14:27:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6geOqD3Fn2e0LWD9omU62mC0bG8=; b=Bn+Am6
	SjmmZsJm38noDiHZMLYFRwNJ6ldtCchewwvFhe+wMGqbIJmkVTqk6ZuY6SXK4DVV
	78ObLL9ubPUH16+ZMXfy2VDzU95r0T6vcc+9i9+TlJROj2WSv9UjfXOaA+V7xi3h
	nTQyvBSHCLOdw9PpJCmdZxxHTD8S1uiQvnQKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c7KGiefqRi+bTjJi4PRzPApe+kJVtJKL
	JTE12yT44OOhOeJQyD37v7LyMQG9rsnesVurv5XJkIyAc9H0zXWX5oC72TFKsCZD
	63oK3pVtgmp9p4Qo/4vskmuJQjb9VDnHqStx9Z4TcZQeEIicJI54sxJA6rAxRKY6
	bhm2qRWxEwU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E13847232E;
	Tue, 18 Mar 2014 14:27:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F6AE7232D;
	Tue, 18 Mar 2014 14:27:21 -0400 (EDT)
In-Reply-To: <1395136856-17225-1-git-send-email-benoit.pierre@gmail.com>
	(Benoit Pierre's message of "Tue, 18 Mar 2014 11:00:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F1A57B3E-AECA-11E3-8E76-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244365>

Thanks; will replace what has been on 'pu' with the updated series.
