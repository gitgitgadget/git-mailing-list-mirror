From: E R <pc88mxer@gmail.com>
Subject: Re: not all tests pass when on an NFS partition
Date: Tue, 17 Feb 2009 08:41:30 -0600
Message-ID: <3a69fa7c0902170641m2ba9b8aeo950c9e3868ba6244@mail.gmail.com>
References: <3a69fa7c0902121220n4ea2f19di6fe984dd2002772@mail.gmail.com>
	 <7vk57vjqsd.fsf@gitster.siamese.dyndns.org>
	 <Aq-rucZsypJQU8SHtTE8X62cEZZn-xSpOOIfA-I5czdtCkm2IyMjDw@cipher.nrlssc.navy.mil>
	 <3a69fa7c0902151219y270681f7r17a108fdf44213ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Feb 17 15:43:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZRA4-0004Ff-Oz
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 15:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbZBQOlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 09:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbZBQOlc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 09:41:32 -0500
Received: from an-out-0708.google.com ([209.85.132.244]:12837 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbZBQOlb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 09:41:31 -0500
Received: by an-out-0708.google.com with SMTP id c2so1179008anc.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 06:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IED3rBPLtcELBZX4i5BF4LhcUjWqrmDB/jrvKSetmuQ=;
        b=Ca3E+19V6kZQ46LTXB8JppVtcUF/e9fE04FsLv3SKw7uS+sfNCUMotCC3BT5FjgOU7
         FkH/mBbWaCyMMZe7BBeeOo5c07OSlZnnwMftctQRl+jPSJ2YfY13G5v1QTYjI5tn4qT2
         5QbCnv3DPuUxAlD4X8bOM7MT0RIHV6wDWnNAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ONKLjrVqZ2GZkNkA3fZrDAixgFjGe0EeIuaNNCkWUWxBXzg6A/5fnfl701atHkGvlF
         XN5d3mo8K11kH6A01M/i6OZ56yIf3wEGpD0k0/hqrbMGO2HeF+1HVedw1cXim49/KVC6
         DU36jBwSeL0u/nuFmrLY+ZGEe/mPPsybbjCSM=
Received: by 10.100.3.4 with SMTP id 4mr2311453anc.103.1234881690271; Tue, 17 
	Feb 2009 06:41:30 -0800 (PST)
In-Reply-To: <3a69fa7c0902151219y270681f7r17a108fdf44213ad@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110392>

Btw - what kind of risks are involved in using git when test
t5304-prune.sh doesn't pass? Do we risk repository corruption?

On Sun, Feb 15, 2009 at 2:19 PM, E R <pc88mxer@gmail.com> wrote:
> On Thu, Feb 12, 2009 at 6:54 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>
>> RHEL 5.2? me too.
>>
>> RHEL 4.7 works fine, same NFS server (running 5.2).
>
> Yes - it's Centos 5.2. Very interesting.
>
