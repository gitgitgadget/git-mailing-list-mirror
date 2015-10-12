From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Reinstate the helpful message when `git pull
 --rebase` fails
Date: Mon, 12 Oct 2015 11:46:59 +0200
Organization: gmx
Message-ID: <793ef29a6d9c77b4f4be478239b74089@dscho.org>
References: <cover.1444336120.git.johannes.schindelin@gmx.de>
 <xmqq612grhg7.fsf@gitster.mtv.corp.google.com>
 <CACRoPnSPVMt+FtK6bwfa7Z3jBheTEkBnhU+B7qL8JrAsSmAmkQ@mail.gmail.com>
 <xmqqk2qvq570.fsf@gitster.mtv.corp.google.com>
 <xmqq4mhzq41e.fsf@gitster.mtv.corp.google.com>
 <xmqqzizroorx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Paul Tan <pyokagan@gmail.com>,
	Brendan Forster <shiftkey@github.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 11:47:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlZhL-0007zk-QN
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 11:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbbJLJrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 05:47:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:50185 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178AbbJLJrL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 05:47:11 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LqRKT-1aFyYn1l7h-00e28t; Mon, 12 Oct 2015 11:47:00
 +0200
In-Reply-To: <xmqqzizroorx.fsf@gitster.mtv.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:Uj4FC4FNOSj+5sJE0ablopyH4RE8mq7AAcOq8xrm2P8nwJ5bZmA
 gOvRAb/kIIOl4fSeP3fvMDhDyTdECzqkkF3+hAX82Ma691hjPGx5XmTss+xugF64xYSSIqn
 QKRLMjuNt0qiYgG6L0d3RHtTreNrQksEwJi1rtKAy/8qRXtoxwgvpg8j7DFfFCeKMUklmT7
 q93vgjXEARqepPrdV4F8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1xygxksFrsI=:34HQQ6X72+4Uaj+9fJjSaM
 /Tlx3/9QHf/+0xHFaby0jtMHB/Sag5UdFHQrCFqUXLLx1A3z4q89G8lUsoiZp4Gs/9VlQYSMb
 AyCX6+yhgYvT/BksQaUxZewsNV91Qj5tnD0voF9sKRt/bplpwOJlbU1tm7GVXTrzGOPKFjSYj
 IWh6Iwoqr6rsZddjU97G3IkcgV2zR7oaRzkhfqkbrrDmlSZmkx0UCtmq2HJEJjGWb5QwJKG3V
 KCfGqLpttMgKHO26/9fBPhVM0k95zkumMJzAfR3axU4O6OjPn+v5GE1A8sLD3OHoO49vxo1xc
 hL9Bacth+ko1YsvtD1lgr7jY44vP8wcoXXqYfOZvGz+Fq2+9L6uAdRm8x2SzzUZxf7Z8XBEe8
 caXgNg4n4z/10oxynpK2TSw+F32u6DT0tuvvQL/F94s/dYuyJVARJNgZscO47pOtLIH3aY+rC
 NT+Wlc6GnN0edykMJLrM3MIBVVFPiKjIFbXqy550SapHOFwJB8dFyFInqs6mgFNjr3lChvMIN
 pCPI+sBjFUpfZTdHxsZGOgL4j4FUzAOIhHNlKcwk/mpXoVRqT6xmUHJBvPr/bU0rfpgl+o/zU
 ivGhFatruvTqF1X/4Wp89mCixlspdKp0D2sPVhXVvtaRgHDQ9qsZBq5m6xYSdAB9Xel220ZYp
 HEB6eDmaOnRb14PQyYUGyJvafN9JcfiUnMm9Txas0eAcl9xQTU4ec9GfcKYtqcf4Nad1BtoJs
 qEY8D20xmJkTT5GHLxb+SyuBpGX6Uf68o0XlRlE0dijSr5+4OsiN9SttWoD7lWw2Sh+PS68G 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279370>

Hi Junio,

On 2015-10-09 20:55, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> I would prefer the endgame to be an efficient implementation of
> merge_recursive_generic(), a function that you can call without you
> having to worry about it dying.
> 
> But the patch in this thread is not that, if I am reading Johannes's
> description correctly.  

As pointed out by Paul, the recursive merge should only die() in case of a non-recoverable error so serious that not even rerere can do anything (such as a read error).

The bug is that a code path for a non-recoverable error is taken.

Spawning the recursive merge would be a work-around making the need to fix that bug less urgent, nothing more. (So would introducing the 'gentle' flag, of course, albeit without the performance regression of spawning a new process.)

Ciao,
Dscho
