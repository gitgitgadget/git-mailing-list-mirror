From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH] filter-branch: add git_commit_non_empty_tree and --prune-empty.
Date: Fri, 9 Jan 2009 14:29:15 -0500
Message-ID: <76718490901091129q534ca981iac54e0653d76170d@mail.gmail.com>
References: <20081030132623.GC24098@artemis.corp>
	 <1225445204-28000-1-git-send-email-madcoder@debian.org>
	 <7viqr5wgl7.fsf@gitster.siamese.dyndns.org>
	 <20081103092729.GE13930@artemis.corp>
	 <20081103151826.GJ13930@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	pasky@suse.cz, srabbelier@gmail.com
To: "Pierre Habouzit" <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Jan 09 20:30:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLN44-0001YE-Tx
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 20:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbZAIT3R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 14:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbZAIT3R
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 14:29:17 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:47176 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbZAIT3Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 14:29:16 -0500
Received: by rv-out-0506.google.com with SMTP id k40so9054137rvb.1
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 11:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=wwLOWZ5aT3ncuiI3I7VImZUDNF9w/Q84oe1V4QswAPU=;
        b=u0tDdKPM4v9U6NCSeUWwfF2KbYuopbl9KtjMGAPOdJK+dmS/wCl3++VgVsPvvShFrY
         ZA08p8VvuYE5KQ2XZtpR4OX42Nmv1XVNIWP1cuBqZt7KTEhc6kGvdnE2Q1ZT9Y7UJkgF
         qNR4H4UogQdkXX7lLxL/ycsZ5+8eMMR0oHs5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=oNYj3vCqWEFUzZip4q+HLJRP3B3qhHuPWRufsMy3Qm+t0NUQAtc2KfsD6FVvU94P5Q
         54y5FFr7BX0x5gd3Dr00AZM51agyh4xIZSDpRVl951PWTOzCu9HCJPbfqOyhE01RP/w6
         QeARRKOKo1uVBjf+Mu4mlVwOg3kM3EAyDo0jk=
Received: by 10.141.172.6 with SMTP id z6mr516620rvo.0.1231529355454;
        Fri, 09 Jan 2009 11:29:15 -0800 (PST)
Received: by 10.140.135.1 with HTTP; Fri, 9 Jan 2009 11:29:15 -0800 (PST)
In-Reply-To: <20081103151826.GJ13930@artemis.corp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105032>

On Mon, Nov 3, 2008 at 10:18 AM, Pierre Habouzit <madcoder@debian.org> wrote:
> On Mon, Nov 03, 2008 at 09:27:29AM +0000, Pierre Habouzit wrote:
>> On Mon, Nov 03, 2008 at 04:58:44AM +0000, Junio C Hamano wrote:

Bump, http://thread.gmane.org/gmane.comp.version-control.git/99440/

(I'd like to see this included. Having a bunch of empty commits after
using filter-branch to remove unwanted files from history is, er,
sub-optimal, so seems like it might even be default behavior?)

j.
