From: Junio C Hamano <gitster@pobox.com>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Wed, 07 Sep 2011 14:08:03 -0700
Message-ID: <7v39g82h8s.fsf@alter.siamese.dyndns.org>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
 <4E6769E3.4070003@drmicha.warpmail.net>
 <CAFcyEthuf49_kOmoLmoSSbNJN+iOBpicP4-eFAV5wL5_RffwGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Kyle Neath <kneath@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 23:08:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1PLw-0000CH-T5
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 23:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756980Ab1IGVII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 17:08:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756943Ab1IGVIG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 17:08:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 004CD427F;
	Wed,  7 Sep 2011 17:08:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jl2xOSsUSxHj3ymLiiRVR/Fe92k=; b=uDYASI
	fVy0z3VsQVN7yLdwxKH1uyFj+0fUl12g8LkTqbbtRus6S0bA3H6Nva4m+O/mDB2Y
	wwYuEuK6Ik1L6T97bFbP91/KfvUrnHxDNb1HFsftEq0zYTyGV76CZpcJ/3pGGyO2
	3uA96jyv+w/vaTOHRUntfGmIndA3AGFXrRpoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TRlZOYYFodoTxT44wniLC8iIx8DqbqRo
	S6Q8Q+q2BcZoOm1CE+BUGsA7RkAjt2JCtTLCFYtNACTtBi26ww5LkW+eANlGTLTp
	7pC5Q9DfWRqWM3PqhB+nLbEMef88WPXqXwwWk4XR92sP7E9dxw7rltqUpYKgBQbe
	eYXKk+AzP+Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C91FE427E;
	Wed,  7 Sep 2011 17:08:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47207427D; Wed,  7 Sep 2011
 17:08:05 -0400 (EDT)
In-Reply-To: <CAFcyEthuf49_kOmoLmoSSbNJN+iOBpicP4-eFAV5wL5_RffwGg@mail.gmail.com> (Kyle
 Neath's message of "Wed, 7 Sep 2011 13:14:01 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7AB2F8D8-D995-11E0-B752-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180911>

Kyle Neath <kneath@gmail.com> writes:

> ... However, I do think this feature is
> important enough to delay the release. I trust in the judgement of the core
> members to know when something is ready for inclusion in master.

We do not delay a release for any new feature, as we shoot for 8 to 10
week release cycle these days. For an important feature that we must avoid
painting ourselves into a corner that we cannot get out of if we screw up
the initial design due to possible backward compatibility issues, it is
even more true than other minor features.

This cycle is being delayed longer than anybody wishes for an external
reason, and unfortunately it does not mean we have longer period to
eyeball the topics in cooking due to that same external reason.
