From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 14:18:24 -0700
Message-ID: <20130410211824.GC27070@google.com>
References: <7vhajemd1x.fsf@alter.siamese.dyndns.org>
 <20130410185958.GA22394@sigill.intra.peff.net>
 <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <CALkWK0k44+VnrGTXESdap2nRomdYH8xwz_T2JdhYtSrPR+89sw@mail.gmail.com>
 <20130410200548.GC24177@sigill.intra.peff.net>
 <CALkWK0mEe+p3RX2tamW8dmdY_eP74Rdh_pZDRDPNfzX0TOKQCQ@mail.gmail.com>
 <20130410202456.GF24177@sigill.intra.peff.net>
 <CALkWK0k_gYWg9=zjRKGrq-evsWG+hCrLjrpLfYp=_uoHVKBzHw@mail.gmail.com>
 <20130410210455.GA2999@sigill.intra.peff.net>
 <CALkWK0k-YJwT__8Tc4B4WXq30ij3i8_d6qwyOCP5RLsKF9eazQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 23:18:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2Pd-0000SC-VM
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934492Ab3DJVSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:18:33 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:57240 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934415Ab3DJVS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:18:29 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so484555pdj.16
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 14:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=eW3hSFnkKxT12Z3sHHBjWeoCRYbneQFjaqoYUaVIAUs=;
        b=OcCX33CxhP6n5cVzh3ZFxjWUrZdQwHq52+GX4T+0/36KCnFkYuKHvvGdnNq8tHRBhj
         tfuzEIYvKNMBFSQuJb7bk1zBhCGg67R+ZPx7TFhgOdQ6KCiDfQEd9yUQvIKf8lSJhqkU
         DTRc/c1b2BwBAv0ZdztAyAx+Yz8gY8Zi2kZsNq4JDFYRLWFczjdWwgcOAO0DP8u4UWli
         T4YAGpp4DZa7/0ac5fZ7Zgb8wjwFXKidrbrlGukiXsPLzHm14GCXwn5rq6J1nnMfcVKh
         H6jrZQirFFDM7msBZrW+IQt7oK4PEym6/iimbmWMawmPixdWm37nJMIhRiQFQg/kW63z
         kI3w==
X-Received: by 10.68.95.133 with SMTP id dk5mr5074672pbb.171.1365628709346;
        Wed, 10 Apr 2013 14:18:29 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id dg5sm1271256pbc.29.2013.04.10.14.18.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 14:18:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0k-YJwT__8Tc4B4WXq30ij3i8_d6qwyOCP5RLsKF9eazQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220769>

Ramkumar Ramachandra wrote:

>                                My point is that we should have "sane"
> defaults, and fine-grained configurability so that uses who disagree
> can maintain their own configs.

I don't agree with this principle.  I like a tool that behaves sanely
with little work and that is flexible enough to do hard things when
that's needed.  Neither of those attributes implies configurability,
except in those unfortunate cases where "behaving sanely with little
work on the user's part" has to involve a different behavior from
person to person.

When people disagree about sane defaults, that's a sign that we didn't
understand the problem well.  Often more thinking can lead to a
simpler answer.
