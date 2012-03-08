From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.10-rc0
Date: Thu, 08 Mar 2012 12:07:27 -0800
Message-ID: <7v8vjadfgg.fsf@alter.siamese.dyndns.org>
References: <7v7gyvkh84.fsf@alter.siamese.dyndns.org>
 <CAFouetgY+HSFksZkOGHcD41kHwfedtta0XoDemwyfQKOiJM1RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 21:07:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5jcd-0003rC-C5
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 21:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758324Ab2CHUHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 15:07:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42618 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897Ab2CHUHa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 15:07:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2FB461EB;
	Thu,  8 Mar 2012 15:07:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WuxFeppOxMh28Aj70xbyHfwCWrY=; b=gHQirG
	wl3vjhb9Wa+FLxo5wq+l27adIrianMQSqpkbPmoaySDOqa/uQd+6XW0QyhmYI+qZ
	ofaswfirQ8j9LlYxfifoISB1Q0+vGuGwAvE3e4wIfKYdWOv1/G0QZfg8nH1avmW/
	GPEMGRli+gdirzbRbKlW7lkGei/Bhuh5WI/Jg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RZwOe36tZpxXzE7MJNXLE1h79KwpbjdV
	MdY4pLGXnwLYv/6FfQ6chLQCVpX4KBRCV6iEfDK33JRTM0XGZlXKkn1VmohAoPnl
	SnyNCS5bZ6xAIyfWz1ES03+QQrd3PcEe3TyyyJbR4idm4++t6/wyjUfIfLAc2I1W
	nLkxS53JbmE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CADF461E9;
	Thu,  8 Mar 2012 15:07:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E69461E7; Thu,  8 Mar 2012
 15:07:29 -0500 (EST)
In-Reply-To: <CAFouetgY+HSFksZkOGHcD41kHwfedtta0XoDemwyfQKOiJM1RA@mail.gmail.com> (Tim
 Henigan's message of "Thu, 8 Mar 2012 08:18:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 55204314-695A-11E1-B578-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192641>

Tim Henigan <tim.henigan@gmail.com> writes:

> On Wed, Mar 7, 2012 at 8:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Updates since v1.7.9
>> --------------------
>>
>> UI, Workflows & Features
>
> Are additions to contrib/ normally mentioned here?

Usually not.  You could send a patch whose addition does not exceed
three lines if you want, though.
