X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: unmark after committing with git.el
Date: Wed, 06 Dec 2006 15:24:27 +0100
Message-ID: <87irgp85lw.fsf@wine.dyndns.org>
References: <4576BB0B.9010200@xs4all.nl> <el6eku$vg7$3@sea.gmane.org>
	<4576C0FB.8060000@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 14:25:06 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <4576C0FB.8060000@xs4all.nl> (Han-Wen Nienhuys's message of "Wed\, 06 Dec 2006 14\:09\:15 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33460>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grxhg-0001AI-DU for gcvg-git@gmane.org; Wed, 06 Dec
 2006 15:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760647AbWLFOYk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 09:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760646AbWLFOYk
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 09:24:40 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:58247 "EHLO
 mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1760647AbWLFOYj (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 09:24:39 -0500
Received: from adsl-89-217-133-170.adslplus.ch ([89.217.133.170]
 helo=wine.dyndns.org) by mail.codeweavers.com with esmtpsa
 (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32) (Exim 4.50) id 1GrxhK-00024Q-Pv; Wed, 06
 Dec 2006 08:24:36 -0600
Received: by wine.dyndns.org (Postfix, from userid 1000) id 9D62F4F672; Wed, 
 6 Dec 2006 15:24:27 +0100 (CET)
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> Jakub Narebski escreveu:
>> But this break I think PCL-CVS behaviour compatibility. By the way,
>> [Backspace] should unmark all files.
>
> it's M-DEL.
>
> Is complete PCL-CVS compatibility a target?

As far as possible, yes. Note that you don't need to unmark the files
to do the next commit, the files you just committed should be in the
up-to-date state, and those are ignored when committing (and in most
other operations too).

-- 
Alexandre Julliard
