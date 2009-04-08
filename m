From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] list-objects: add "void *data" parameter to show
 functions
Date: Tue, 07 Apr 2009 22:10:26 -0700
Message-ID: <7vk55vspbx.fsf@gitster.siamese.dyndns.org>
References: <20090407040819.4338.4291.chriscool@tuxfamily.org>
 <20090407040854.4338.94304.chriscool@tuxfamily.org>
 <7vk55vubcv.fsf@gitster.siamese.dyndns.org>
 <200904080639.35499.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Apr 08 07:12:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrQ4z-0003tc-9m
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 07:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940AbZDHFKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 01:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752918AbZDHFKf
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 01:10:35 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62091 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbZDHFKe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 01:10:34 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8DFE6BB85;
	Wed,  8 Apr 2009 01:10:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D841DBB83; Wed, 
 8 Apr 2009 01:10:27 -0400 (EDT)
In-Reply-To: <200904080639.35499.chriscool@tuxfamily.org> (Christian Couder's
 message of "Wed, 8 Apr 2009 06:39:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9543F56E-23FB-11DE-AFAF-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116035>

Christian Couder <chriscool@tuxfamily.org> writes:

> This is the relevant hunk in patch 2/3:
>
> diff --git a/bisect.h b/bisect.h
> index f5d1067..b1c334d 100644
> --- a/bisect.h
> +++ b/bisect.h
> @@ -14,12 +14,14 @@ extern struct commit_list *filter_skipped(struct 
> commit_list *list,
>  #define BISECT_SHOW_TRIED      (1<<1)
>  #define BISECT_SHOW_STRINGED   (1<<2)
>  
> -/*
> - * The flag BISECT_SHOW_ALL should not be set if this function is called
> - * from outside "builtin-rev-list.c" as otherwise it would use
> - * static "revs" from this file.
> - */

Thanks for a clarification.
