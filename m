From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC] Delete current branch
Date: Fri, 19 Jul 2013 22:20:01 +0530
Message-ID: <CALkWK0kdCFn6YevL5nZXwYQ2u+2RdvQqEXEiVfyeXhrq_QG7AQ@mail.gmail.com>
References: <CALkWK0=8q4J2yi2to_+41kJSA5E59CBwkG69Hj7MmTPgUnSh5Q@mail.gmail.com>
 <7vr4euy4c6.fsf@alter.siamese.dyndns.org> <CALkWK0m-q=Aoof62zhXnUYsJ7PQZwTLbQ50BUEmufVO4gtWNUA@mail.gmail.com>
 <7vppuewl6h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 18:51:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0DtT-0002rq-7P
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 18:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760904Ab3GSQup (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 12:50:45 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:52108 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760179Ab3GSQun (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 12:50:43 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so9746284iet.23
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 09:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=EAeIqeDCuNDQPJVjFI8phgpcQvSL/0N2evjGLkPiwCw=;
        b=Ut8/C8ak4XhfinRs4XT6RS2FQr6KDQENUNc8T47H1SJANdK+T1/DEvt+IkTcyAWcoO
         cGE8r6kH30pazVcvjQPvjzKf9kRwmBAMT7R6GtkhH/6R4zIBI2aA5dV2wu6FpMl4DXFD
         E71N/YWFQHpDRF+9o00Zm24RYSBUMe45o2myCo3rGfTTRxlOorobR+aEgU/6uWlRLWBU
         lWTAWWsBNH/zRnn2HMl6zN1E4Pj8CkEnSASmbB3O/kqRD9POlEfYpm0YcTmLiDlIjCEz
         jgWToGGcKubx0jb4C7eZKQYB7Xr+6dge6VS17jq7H3DGwALXm4+gbPlEqEE2nH53th2G
         2SxQ==
X-Received: by 10.43.15.68 with SMTP id pt4mr11524551icb.35.1374252643056;
 Fri, 19 Jul 2013 09:50:43 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 19 Jul 2013 09:50:01 -0700 (PDT)
In-Reply-To: <7vppuewl6h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230829>

Junio C Hamano wrote:
> That limits the context we could use "-" and we cannot consistently
> use it everywhere. I find _that_ ugly from the "design cleanliness"
> point of view.

Right, noted.
