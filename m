From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH RFC v2] builtin-push: add --delete as syntactic sugar for  :foo
Date: Tue, 29 Dec 2009 20:05:23 +0900
Message-ID: <20091229200523.6117@nanako3.lavabit.com>
References: <20091109130935.2bea7771@perceptron> <7v8wefy6pi.fsf@alter.siamese.dyndns.org> <20091109192044.605e50ba@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 12:05:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPZtg-0001Wv-2n
	for gcvg-git-2@lo.gmane.org; Tue, 29 Dec 2009 12:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbZL2LFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2009 06:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbZL2LF3
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Dec 2009 06:05:29 -0500
Received: from karen.lavabit.com ([72.249.41.33]:39004 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766AbZL2LF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2009 06:05:28 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 9480311B8BA;
	Tue, 29 Dec 2009 05:05:28 -0600 (CST)
Received: from 4391.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id 2DDIAD6PN8NI; Tue, 29 Dec 2009 05:05:28 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=d0WAqSd0PlyR9mi8kP4atQsd01WXqfqHia0op0G0nrRZuZFnkbUNusXsnpTBYXGftGZJKx4n99xa4HPeIDors9yNNYne+HtQwNzbVunm4YIkK5w51Wql4fp0+T0VMA1gadKcQKAoUvfAlivNTyvmaJlQzsHWDW8P1IOAYlITi+E=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <20091109192044.605e50ba@perceptron>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135789>

Junio, could you tell us what happened to this thread?

The patch implements "git push repo --delete branch" and rejects
--delete used with other options like --all and --tags, as
suggested in the initial review.  I think it makes sense, but
nothing happens after that.
