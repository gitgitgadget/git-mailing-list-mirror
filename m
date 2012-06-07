From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 3/5] Export three functions from diff.c
Date: Thu, 07 Jun 2012 10:44:02 -0700
Message-ID: <7vaa0fhva5.fsf@alter.siamese.dyndns.org>
References: <cover.1339063659.git.trast@student.ethz.ch>
 <3d2d6819e02104dc954bd56be996e664dba90c54.1339063659.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 07 19:44:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Scgks-0004wz-Kh
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 19:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932576Ab2FGRoG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 13:44:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57964 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932308Ab2FGRoE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 13:44:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E4208F69;
	Thu,  7 Jun 2012 13:44:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=orXaKU+Ljb7/Jh9JV+eCt3/wf0c=; b=Kf3kj1LhBF3vaZTLQ29Y
	xCc/JNNTPb0xrgkkELPs2UGGhXD384SPrIUa3u5ofIPK0eWT0jrJcz6q67mQBILd
	2DrLEoHhSbV/klqLwpBtxyPIqTrK3UJZNjcUCo0ze3h9Tw5Wuo3pZpinCwGmAAYq
	RL+ZlvZvc84I/i1iIERUPm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Pqi6J30bJTnP/hzxLGD/llTsB5zRUbsvXzwdDL2HN00FMa
	DEXo3Ev9q/fDaQ6LAP+U1XS1ruf5ypJXovPNoRIwT7hY5BqJETnUiQr1vrqGG7Pl
	cbUPqDRIYcdzyUb8oJ+UoiXj/WpdtR6rscjVZuSfNlX3GW+0AGpul1EkPzeyU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35C298F68;
	Thu,  7 Jun 2012 13:44:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C50558F67; Thu,  7 Jun 2012
 13:44:03 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5F64254C-B0C8-11E1-805A-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199425>

Thomas Rast <trast@student.ethz.ch> writes:

> From: Bo Yang <struggleyb.nku@gmail.com>
>
> Use fill_metainfo to fill the line level diff meta data,
> emit_line to print out a line and quote_two to quote
> paths.
>
> Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---

Why?  Neither 4/5 or 5/5 seem to use any of these.
