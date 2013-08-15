From: Ben Tebulin <tebulin@googlemail.com>
Subject: Re: Reproducible, corrupt packfile after fresh git-svn checkout message
Date: Thu, 15 Aug 2013 11:32:28 +0200
Message-ID: <520CA02C.1020801@gmail.com>
References: <52037F47.5010302@exxcellent.de> <52037F84.9060006@exxcellent.de> <f1d8f80d6fa3678ac043bfdb19bebf6bf4261273@localhost> <877gfw4byx.fsf@linux-k42r.v.cablecom.net> <262a9f8309a3812970f47ac9f4e4b49bb972ca49@localhost> <87fvuk2wl0.fsf@linux-k42r.v.cablecom.net> <9aa1672d5c04994f416dccd84b5983c960c0fdf9@localhost> <vpqli4cfhhe.fsf@anie.imag.fr> <813506281f7a4d3a8af650c5f8ee33dd7224f193@localhost> <vpqfvukfgr5.fsf@anie.imag.fr> <edc9f41b4ffca9ce36dc50e749de7a86e4618a0e@localhost> <87fvuk1cyl.fsf@linux-k42r.v.cablecom.net> <5203B100.30008@gmail.com> <87txj0i4mc.fsf@inf.ethz.ch> <7vsiyk9j6a.fsf@alter.siamese.dyndns.org> <5204E018.4000808@gmail.com> <877gfok59m.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <stefanbeller@googlemail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Aug 15 11:32:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9tv3-0004Fi-Uw
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 11:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497Ab3HOJcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 05:32:33 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:57435 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753378Ab3HOJcc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 05:32:32 -0400
Received: by mail-wi0-f178.google.com with SMTP id j17so2891179wiw.17
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 02:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=BfJuEJyut7Tobp2K5uCYiV6vJfA6hQtqJCKKBo82ZqI=;
        b=CCwhbMCp8XMJYKrjYAcKA8GEZm2RRxLpK+mpviyfuICQAqmDTtj98icOdAEHxE05xu
         6p7XtgoMqAwDFdg2Hz8/PPuUuaE3t/ib2z6vifp0pqefenohMGUafWpyceIxeEW3fFs3
         WzmCkNA9LhFJ0Z0JVaYn+klq1lUn2xj3CJHhNTdJplglrEb7K2zcILcuReov2ytmH4YJ
         D3C2qUo54hy2ebfv8hZNMaKwK46NiKi8B8ptruf1juJEvo8gBzoVqxPfb7YOsNNRII0/
         MvJVPX4j767c06s1KkyQ5EgdHT767xgRhluq1C/MMV361Ge7rKCdLNa7qdO8aRVl7iXw
         OyPw==
X-Received: by 10.180.11.233 with SMTP id t9mr1256061wib.41.1376559151777;
        Thu, 15 Aug 2013 02:32:31 -0700 (PDT)
Received: from [127.0.0.1] (ulmg-5d845cdb.pool.mediaWays.net. [93.132.92.219])
        by mx.google.com with ESMTPSA id b13sm1804587wic.9.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 02:32:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <877gfok59m.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232339>

Just as a catchup for everybody being interested:

I finally wrote to the linux-mm newsgroup and Linus pointed out, that
this might be a known bug yet not fixed in mainline.

Unfortunately this doesn't seem to stand the test; but as far as Git is
concerned, it appears that that they are willing to take actions.

http://thread.gmane.org/gmane.linux.kernel/1541707/focus=105432
