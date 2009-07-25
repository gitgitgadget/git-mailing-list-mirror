From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git fast-export: add --no-data option
Date: Sat, 25 Jul 2009 10:25:05 -0700
Message-ID: <7vfxcku13i.fsf@alter.siamese.dyndns.org>
References: <7f9d599f0907250645s6e6f9b81w3cf20f07eff088eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Sat Jul 25 19:25:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUkzw-00068M-C7
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 19:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbZGYRZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 13:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbZGYRZQ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 13:25:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbZGYRZP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 13:25:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 05DA8110C0;
	Sat, 25 Jul 2009 13:25:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AE46A110BD; Sat, 25 Jul 2009
 13:25:07 -0400 (EDT)
In-Reply-To: <7f9d599f0907250645s6e6f9b81w3cf20f07eff088eb@mail.gmail.com>
 (Geoffrey Irving's message of "Sat\, 25 Jul 2009 09\:45\:19 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1DA50E2C-7940-11DE-A60E-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124023>

Geoffrey Irving <irving@naml.us> writes:

> @@ -504,6 +508,8 @@ int cmd_fast_export(int argc, const char **argv,
> const char *prefix)
>  			     "Import marks from this file"),
>  		OPT_BOOLEAN(0, "fake-missing-tagger", &fake_missing_tagger,
>  			     "Fake a tagger when tags lack one"),
> +		OPT_BOOLEAN(0, "no-data", &no_data,
> +			     "Skip output of blob data"),

Shouldn't this be --[no-]data option that defaults to true?  Otherwise you
would accept --no-no-data that looks silly.

>  		OPT_END()
>  	};
>
> -- 
> 1.6.3.1
