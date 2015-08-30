From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v14 07/13] ref-filter: add support for %(contents:lines=X)
Date: Sun, 30 Aug 2015 22:47:13 +0530
Message-ID: <CAOLa=ZQn89f+Az56hwxu7X81VoifWs6OFxCC=G1PZ+c-dJWcRw@mail.gmail.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
 <1440857537-13968-8-git-send-email-Karthik.188@gmail.com> <CAPig+cQmAkFAjUcJNJNF2gwunX6TKK+oQsd2QnmJwxLT=EEvjQ@mail.gmail.com>
 <CAOLa=ZSgjrg60r6bdWfCHC+J9_q+ZWUHXc7j_9ePkdTBE1+-Kg@mail.gmail.com> <CAPig+cROyc7vxddkfGSsBayT9i=VSacxcEuuNkEFf+oYoUs9kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 19:18:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZW6F3-0001K9-Ra
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 19:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbbH3RRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 13:17:44 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:36309 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523AbbH3RRn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 13:17:43 -0400
Received: by obkg7 with SMTP id g7so75251059obk.3
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=G6szt+o+LN8gnAFh/tbgzgbtqPXasqu+mo4mOaYGi4w=;
        b=n1zXqelJaDXtq6tlWBL7Hzbocu1Ct/Rjku6hwqTSk0Zo1E0t7dO8pdIx4FWR3pkqFC
         frbxI8RDiyAW+RsPXVLTj17NeNMcdSSrqnF/4JLwGyWf+rh4shviuFcttxHxNLWdJPh7
         Py5mvCOYOk+6wPML0ezEBNXzrcgdfi+B6UW8yRyAvQdGyO6T3Ymtn4k3HWhp3iagSaBM
         FfMtUv8/OC57tX+Sx4oWdYR1XKL/jxmM4K/cnW2xZUtniFhw5bzDM1BxBi6C4ivnudLk
         Q30RfQ9mS7WQlmi8CwP/ehENS+cPWAQNT1c4bdhz0NsAs/la4ZhZLC2sPBhgw0SSCkkX
         lqxQ==
X-Received: by 10.182.171.35 with SMTP id ar3mr10925883obc.57.1440955062673;
 Sun, 30 Aug 2015 10:17:42 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sun, 30 Aug 2015 10:17:13 -0700 (PDT)
In-Reply-To: <CAPig+cROyc7vxddkfGSsBayT9i=VSacxcEuuNkEFf+oYoUs9kg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276827>

On Sun, Aug 30, 2015 at 10:39 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> I meant "mutually exclusive" in the sense of only one or the other of
> 'align' and 'contents' ever being used within a single 'atom_value'
> instance. (I wasn't referring to the user experience.)

Sorry for the confusion, we're on the same page :)

-- 
Regards,
Karthik Nayak
