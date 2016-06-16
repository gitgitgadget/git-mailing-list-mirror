From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv8 0/5] pathspec magic extension to search for attributes
Date: Thu, 19 May 2016 11:55:31 -0700
Message-ID: <xmqqiny9j2sc.fsf@gitster.mtv.corp.google.com>
References: <20160519010935.27856-1-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 19 20:55:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3T6m-0003jp-8B
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 20:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbcESSzf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 14:55:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61538 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755277AbcESSzf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 14:55:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FD6E1CCD8;
	Thu, 19 May 2016 14:55:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xf/84bbSefTKdoLbTYXeHYowpHQ=; b=jNY1hO
	IfX/e2R4o0p5104ShgrCcFhwn1rA3Kg6XqDJmLEH0RNuJaRQ1QOpFbn1rX1HK+Zw
	H6aAs0/XSl/Vbj151+3zJmrQnGasxSSnsyler6S0qQPMIvUVZ/lcjvhZLuUOQZG0
	4pHS7jNiPZ7+c+WM4NnVXvTofKxbBJMfLD6Cs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ChpBIZG+dN5NuWhwU+9AScKsewVFXnRE
	JViXCvUPpC0DVtL67OlbwQlTZmCghDz12GNouTq0xFHnWmhfK0wkT76b7Vm9Uk7G
	SSVmZIFooZYEakJCLSfeuFJdAf+vo/h2/NXAvyqBje5IO0IkAB1DNqBfm2gEQhJG
	PC4uuwXVvdk=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 76A421CCD7;
	Thu, 19 May 2016 14:55:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EF3AC1CCD6;
	Thu, 19 May 2016 14:55:32 -0400 (EDT)
In-Reply-To: <20160519010935.27856-1-sbeller@google.com> (Stefan Beller's
	message of "Wed, 18 May 2016 18:09:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 439C359C-1DF3-11E6-9DDD-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295090>

I think this round is 99% there.  The next step would be to answer
"does the feature set we have here meet your needs that you wanted
to fill with the submodule labels originally?" and I am hoping it is
"yes".

Thanks.
