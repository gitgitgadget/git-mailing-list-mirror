From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Searching all git objects
Date: Wed, 25 Jun 2008 18:00:02 -0700
Message-ID: <7v7icdvwml.fsf@gitster.siamese.dyndns.org>
References: <E99352BE-5C43-437E-A5E6-622BEEA03DFA@comcast.net>
 <20080625231742.GT11793@spearce.org>
 <905315640806251632m416a2406x301b857ec7faf09d@mail.gmail.com>
 <321F18C8-351F-4E91-9F00-CFE2711B67D1@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tarmigan <tarmigan+git@gmail.com>,
	"Paul Mackerras" <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Sam G." <ceptorial@comcast.net>
X-From: git-owner@vger.kernel.org Thu Jun 26 03:01:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBfrS-0005sk-K0
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 03:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306AbYFZBAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 21:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbYFZBAV
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 21:00:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33419 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbYFZBAU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 21:00:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9CF1EBEE5;
	Wed, 25 Jun 2008 21:00:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DFB52BEDC; Wed, 25 Jun 2008 21:00:10 -0400 (EDT)
In-Reply-To: <321F18C8-351F-4E91-9F00-CFE2711B67D1@comcast.net> (Sam G.'s
 message of "Wed, 25 Jun 2008 17:49:45 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3D852BF2-431B-11DD-9FD2-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86381>

"Sam G." <ceptorial@comcast.net> writes:

> And, just in case, is there any way to
> search raw objects for text, either commit text, file name or content?
> Thanks very much!

Or run "git lost-found" and grep for blobs in .git/lost-found/other/*
