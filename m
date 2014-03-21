From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] use starts_with() instead of !memcmp()
Date: Fri, 21 Mar 2014 09:53:18 -0700
Message-ID: <xmqqzjkjv6gx.fsf@gitster.dls.corp.google.com>
References: <1395191883-42409-1-git-send-email-quintus.public@gmail.com>
	<CAPig+cTWV0PWOh88u+rbMPvnn3O+OhTJATEtXXi4oLKUN25Ezw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Quint Guvernator <quintus.public@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 17:53:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR2hG-0002e4-I0
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 17:53:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754936AbaCUQxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 12:53:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63341 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761150AbaCUQxU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 12:53:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3709E74173;
	Fri, 21 Mar 2014 12:53:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7/1Te7rY2lwKvtScMWqrq6o3sho=; b=fyrSYW
	c5xyGqqSNlkor16HEUMrsDbCV7YYPG490xDvovgFPoVYB7sZKdGjb3UaoexbOzQf
	t71/IOLJHqMQN8f1YvJaLbOInABWV7mBGYSGz7K+qE3Z4CQztbso3+OQdX0pY2T0
	H+UUjtkpyad0xwknvWKwtjwyzs/0qvL9Dgr1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZFnBpk+OLFqqfyYkns14h7n+c+ghiPiA
	HAVRLEMq+J49hnQoYx165F7i1ica4lCupqPhKU07XhW0K5MwtI7hedoF+DONUFX6
	QmJZGtgmdg8qeaVVHbTtFrVpQY2bt0OGyy4pseUvJK0KulVe0/ig6qVnO+PYLZX+
	747hQvLYDv0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20A7774172;
	Fri, 21 Mar 2014 12:53:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AAEC74171;
	Fri, 21 Mar 2014 12:53:19 -0400 (EDT)
In-Reply-To: <CAPig+cTWV0PWOh88u+rbMPvnn3O+OhTJATEtXXi4oLKUN25Ezw@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 19 Mar 2014 00:13:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4E2D0F84-B119-11E3-AE58-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244700>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Mar 18, 2014 at 9:18 PM, Quint Guvernator
> <quintus.public@gmail.com> wrote:
>> Another version, this time very in line with the review and commentary of
>> Junio, Eric, and Michael.  This version boasts a revamped commit message and
>> fewer but surer hunks changed.
>
> Explaining what changed in this version is indeed a courtesy to
> reviewers. Thanks.

So, is that a "reviewed-by: Eric"?
