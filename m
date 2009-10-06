From: Philip Herron <herron.philip@googlemail.com>
Subject: Code reuse
Date: Tue, 6 Oct 2009 20:18:35 +0100
Message-ID: <ac07bcaf0910061218x148374d0u66b36fae1466ea98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 06 21:25:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvFfU-0002dy-LC
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 21:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbZJFTTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2009 15:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbZJFTTN
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Oct 2009 15:19:13 -0400
Received: from mail-vw0-f192.google.com ([209.85.212.192]:59156 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932373AbZJFTTN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2009 15:19:13 -0400
Received: by vws30 with SMTP id 30so2602687vws.21
        for <git@vger.kernel.org>; Tue, 06 Oct 2009 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=XW1yEhCZQjV6xiZJJwAUFxumBks1RpX9s/TI83/Bmo4=;
        b=Q5E/5+XmJLcCMEe72fC1cuyyodhII27zbz6yjgAM8PmgtyVCvSdxZjBm+IgbRXaqhi
         ZvNlAT7lCIuqHCf0Ha3NRsNjVaoK8GOFp8sGjbVPdA3yYwzWwA+Yu1pXA/nhnWpTsjEP
         D3pIsfHbwUR2uv4SOh8RWJFiHuVJA8uifidWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=tNueeF3ofEBv1pK7WwtFRI5FDz9s7jh9OQdozjYZFJchIuMkXTD4CETv8x8giDEr0r
         jU0Dl11RyyIUEBrgqZABK9b1fZNfk5yCpUhLH0YFvvkRGc1GtnorDLqt19Mg9/v6q+o7
         FYzqJ/YoOeFs/9VIAEkFusvQZ5Yr5S6eSTS8k=
Received: by 10.220.109.41 with SMTP id h41mr2991655vcp.54.1254856715507; Tue, 
	06 Oct 2009 12:18:35 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129633>

Hey guys

I am not sure if this is the right place to ask this question, but
I've been working on a personal project a programming language
interpreter for some time now, but i took 2 code snippets from
git-core namely:

static struct hash_table_entry *lookup_hash_entry(unsigned int hash,
const struct hash_table *table)

function from hash.c and the alloc_nr.

I've changed it a good bit (probably doesn't resemble much of what it
was) to fit in with the way my stuff works but is there anything i
need to like put in my source code to say hey this is based of
git-core, so far is just a comment to say 'based of git-core hash.c'.
Its an open source (GPL) program but i haven't released or made much
noise about it yet because i want to work on it more myself.

Anyways thanks,

--Phil
