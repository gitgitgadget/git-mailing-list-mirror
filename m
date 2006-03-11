From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: [PATCH] imap-send: cleanup execl() call to use NULL sentinel instead of 0
Date: Sat, 11 Mar 2006 09:01:49 -0500
Message-ID: <118833cc0603110601x6ac9b2b6kaa0277981c6dd44b@mail.gmail.com>
References: <20060311085550.GA32089@fiberbit.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Mike McCormack" <mike@codeweavers.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 11 15:02:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FI4fT-0006Ac-Sz
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 15:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbWCKOBw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Mar 2006 09:01:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWCKOBw
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Mar 2006 09:01:52 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:63043 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750838AbWCKOBw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Mar 2006 09:01:52 -0500
Received: by zproxy.gmail.com with SMTP id 13so911626nzp
        for <git@vger.kernel.org>; Sat, 11 Mar 2006 06:01:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qOB+1qcs9jMOqUAw5X/54Xz4MXz2mWHbZi5MSoS5QNpabx0Hx3/zsTtGabjEk1SSjd9FYeA6M6G/8lKmNvn3iVrJSkuNs5wU3LBeWuWZlSThe6CoC/ukJDWv5C/EaQ2IzAKp4HNd7Hc04MkOZhOCQ/UZQe6NfXrjNuJbYxgUTcc=
Received: by 10.35.127.7 with SMTP id e7mr1743827pyn;
        Sat, 11 Mar 2006 06:01:49 -0800 (PST)
Received: by 10.35.39.13 with HTTP; Sat, 11 Mar 2006 06:01:49 -0800 (PST)
To: "Marco Roeland" <marco.roeland@xs4all.nl>
In-Reply-To: <20060311085550.GA32089@fiberbit.xs4all.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17502>

If you're going to fix that, you should use (char *)NULL or
(char *)0, just in case you end up on a machine where
NULL doesn't a pointer type.

(Yup, NULL can be a null pointer without having pointer type.)

M.
