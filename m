From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sun, 21 Apr 2013 13:45:52 +0530
Message-ID: <CALkWK0=BkCxhGvjWwTHe83LHQ7R2t-EAMr6H9VQ1AvBjgYerBA@mail.gmail.com>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
 <1366458313-7186-5-git-send-email-artagnon@gmail.com> <7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
 <CALkWK0nFAzPPb0_jTRev6nuicCV81sRQAbe=277nhyyY8TnQ7A@mail.gmail.com>
 <7v8v4cwd6g.fsf@alter.siamese.dyndns.org> <CALkWK0kiT7vggXgqGs2iiMooiw7TyJEgr2=Yy06S7H1NKiWJ3g@mail.gmail.com>
 <7vzjwsuxzp.fsf@alter.siamese.dyndns.org> <CALkWK0kEngwYQieR=Xmvzu+XqBe+ZFxiWj0C8M-euFavDDaD2Q@mail.gmail.com>
 <20130421080907.GF10429@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 10:16:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTpRv-0005Nt-A1
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 10:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752396Ab3DUIQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 04:16:34 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:56178 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349Ab3DUIQd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 04:16:33 -0400
Received: by mail-ia0-f170.google.com with SMTP id 21so4440310iay.29
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 01:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=AXDvelgrmx4s0kiB0y1WROmXr86CTPEy74ix226MA4k=;
        b=byjw3LqaDCMIz13s2cK/1GpVr40alf1zfGKLtjfIaGBCRvgXWeMNaN/Ng7kgBUV4mF
         856Iek9XYim+eU6DXuJnPv08siq6Ceh8+sq7oCaEGfTaUD61B5bnnC5PPYnKZyJbzFh8
         6uC+UJUEX6NZtfvnjU3zDpxL/PEVaiZHIt4qQzOtO8yZPI0InL7CCXJU+Noof+/uLvPN
         qYxxW9EBBa514qwytU/moepfwCe3XUqbsuOLFFOSCGgWJAM1IgA6vlhW4cbOr8k0uqvq
         eKaYCwYjQ8456JACs2iLRDnPDzzuacLZbG+pVa2nv6yVjRqx1Mt1ZMEoCntcKlXDV9Z7
         NXwg==
X-Received: by 10.42.50.202 with SMTP id b10mr11010853icg.7.1366532192992;
 Sun, 21 Apr 2013 01:16:32 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 21 Apr 2013 01:15:52 -0700 (PDT)
In-Reply-To: <20130421080907.GF10429@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221917>

Jonathan Nieder wrote:
> Am I wrong
> in thinking revision is nothing more than a synonym for commit?

Yes.  If master@{3}~2:README isn't a revision, what is it?  And it
fits into the Specifying Revisions section quite snugly: I see no
reason to mangle the meaning of "revision".
