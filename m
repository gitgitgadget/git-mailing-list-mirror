From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 7/7] git-stash: use update-ref --create-reflog instead of creating files
Date: Tue, 21 Jul 2015 14:20:10 -0700
Message-ID: <xmqqbnf5tdh1.fsf@gitster.dls.corp.google.com>
References: <1437512696-14672-1-git-send-email-dturner@twopensource.com>
	<1437512696-14672-7-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhaggerty@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 23:20:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHexZ-00025A-1H
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 23:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbbGUVUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 17:20:14 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33302 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbbGUVUN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2015 17:20:13 -0400
Received: by pdbnt7 with SMTP id nt7so55733404pdb.0
        for <git@vger.kernel.org>; Tue, 21 Jul 2015 14:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=JR1KzAUcZwmUQme0qERR3cgrBDQr2pIs/2zmns/NYBA=;
        b=a4aBkrGvWgT5iGDp7XyH+ejxXszpugNiY19MWnXtmtg0rRcblQqbWLrPbLkR+SsAp2
         iyOypB+iElhMMXBhferMBZMl/M5O1oPzSkcC3eRvj7i5A1tIWR0YqzCYI1u6fvHkcQKo
         lDKCtMKZ3mM1BhelDFavS9rFY11ZtCh4Okty4JrGdXER1gDrxLsOunG56+FjzXsqt+/d
         9eD1zK4YTgUEdSc9eha6v0s3YvYx5NkiOkvi8t8+ET9MuGqXvhWv1LQ00FT3cbg7EoWE
         2ZY98zt4JXguQWrjB5IPQGS7UgHkUguWkOTQX4zXBMRNxLdJy+4dgZGi6SZ+8IWM0v1u
         2ZnQ==
X-Received: by 10.66.136.102 with SMTP id pz6mr77352068pab.52.1437513612646;
        Tue, 21 Jul 2015 14:20:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3977:fdee:723a:a723])
        by smtp.gmail.com with ESMTPSA id bd5sm11450190pdb.41.2015.07.21.14.20.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jul 2015 14:20:11 -0700 (PDT)
In-Reply-To: <1437512696-14672-7-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Tue, 21 Jul 2015 17:04:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274427>

Compared them with v9, signed them off, and merged to 'next'.
Haven't pushed the result out yet.

Thanks.
