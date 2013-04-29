From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Itches with the current rev spec
Date: Tue, 30 Apr 2013 00:53:44 +0530
Message-ID: <CALkWK0nQhfbX8KQwMxwQ9Lntx1JFwKB4gPVsViz4e7i5c6G+Rw@mail.gmail.com>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
 <20130426101946.433f2d12@chalon.bertin.fr> <517A3E47.6010606@viscovery.net>
 <7v7gjpxjw0.fsf@alter.siamese.dyndns.org> <CAMP44s0-C_TRC_eD_ZbN3WFe4NKWVPQVhh+ME-F5yBBwKs2NdA@mail.gmail.com>
 <7v8v45vvuy.fsf@alter.siamese.dyndns.org> <CALkWK0=W_FxDwc3Tby=h90yc5i8UEuT7maERahFRDQU=hQ633g@mail.gmail.com>
 <7vobcxl3ui.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yann Dirson <dirson@bertin.fr>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 21:27:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWtil-00021X-8L
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 21:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933457Ab3D2TZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 15:25:12 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:46685 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933439Ab3D2TY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 15:24:26 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so7643405ieb.40
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 12:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=tOvUg4dWfQAwpexTa57WgtahpfYbb8Yws97hA5yWgdw=;
        b=DAD2xwbeX3k0VaFvisMay5QKijjSg26ZZS3t+eFHf1cTfaOKVQ0zn3ts4p2Y2jQxca
         kmZ4Jppyuoea5KycrsgVMhkJ1KH7+5LU7czeOsPCQJJ7C3y+19GPvt6I2pvghki1Md6z
         ZUjs0ICMJGd/G3sExG2u8TNqqgkS1h/WlKzzXjmJyCxN1T0DXiRw6KGEd9XcDvkzPX7Q
         VxSSMoeH2ruF8rnNA3cSA8LePglqugp9BVZ2e8v6mWZKdicl5RvdHrZpL3N2y0jPuvC8
         2w1e2lTTAmy5tyKy0XOJJqjjcXqecAn97y1aNfK2OEGt9gLrFuGQ9a79FY4k3LPQY+Ya
         fusA==
X-Received: by 10.50.66.197 with SMTP id h5mr8008059igt.63.1367263465237; Mon,
 29 Apr 2013 12:24:25 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 29 Apr 2013 12:23:44 -0700 (PDT)
In-Reply-To: <7vobcxl3ui.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222851>

Junio C Hamano wrote:
>  * Where the bottom of the DAG being replayed is (i.e. X);
>  * What refs are the top of the DAG (i.e. A and B);
>  * Where the new bottom of the replayed DAG (i.e. Y).

Okay, so can I start writing a series that will make git rebase accept
one negative commit (N) and one positive commit (P) in any order?  A
git rebase N..P should rebase the DAG defined by P ^N onto $(git
merge-base N P).  Does that make sense?

(two positive commits are a special case for backward compatibility?)
