From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/12] Column display
Date: Mon, 06 Feb 2012 09:58:26 -0800
Message-ID: <7v39an973x.fsf@alter.siamese.dyndns.org>
References: <1328276078-27955-1-git-send-email-pclouds@gmail.com>
 <1328371156-4009-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 18:58:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuSpn-0005US-U6
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 18:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076Ab2BFR6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 12:58:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33949 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753743Ab2BFR63 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 12:58:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88CF16758;
	Mon,  6 Feb 2012 12:58:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JvCloKFVlvjuC2QGcs5Od5YIkYo=; b=sVcjNp
	zCr6ExSIb6f+SL5fO9x2GdYcvI+fru/ccnmuvxXFS0GzQOmfMJLH5Ox4uH0fWXjm
	CW4kscV+B46knpS9SjqMYjbHhcXkVZ+CPA6uE5POVJ3B6m1CmfFPaZeG4nmS6w54
	pCehsNDhGPlZsEE6SISrjGojfP9RfGPmO8VE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wwVR1+oU4ZW46QYXyeeDPbAaYpys2x/1
	QT73nkOehzRHpMHIK9+BlQ78AHOzAy02NyQNFi+YN9c48BPHyDT9NSPRnIK1PY94
	1gdM1OnPAxrdSY9OeDkzvvGWs4AtDioVWiIr/IHpeOcw4puaoYnCitRbkBGJHJgq
	GRW0qMFqCUk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 815A36757;
	Mon,  6 Feb 2012 12:58:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EE186754; Mon,  6 Feb 2012
 12:58:27 -0500 (EST)
In-Reply-To: <1328371156-4009-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 4 Feb
 2012 22:59:04 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2C216EF6-50EC-11E1-9A9D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190083>

I've added two patches on top of this series and queued on 'pu'.

The first one is a fix for style issues; this is limited to absolute
minimum and I wouldn't be surprised if I fixed one instance of the same
class of style violations just as an example while ignoring bunch of
similar ones.

The second was to see how "git branch" behaves when it sees one absurdly
long entry (longer than $COLUMN width) among the normal ones, primarily
done just for fun.

You may want to tease the first one apart and squash them in to where the
problem originates. The second one is optional, but as you hinted an
interest on coming up with a heuristic to cram more info by making some
oddball entries span multi-column, it might serve as a good starting point 
to think about the possible issues.

Thanks for an amusing read.
