X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: Shouldn't git-ls-files --others use $GIT_DIR?
Date: Mon, 20 Nov 2006 20:51:32 +0100
Message-ID: <dbfc82860611201151m52933720lfef939b7f6803411@mail.gmail.com>
References: <dbfc82860611190537q77c8a358m184377a21d5a3e11@mail.gmail.com>
	 <20061119183756.GZ7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 19:52:01 +0000 (UTC)
Cc: git <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=T5VZGxu469nXIgKeZ7lx1eJEV24msEBhO27apmbQ8C8Nh1WJm6yFP0EJ5/zs3k/RL57XBzJ+epG1Xa4dDcfH2eh8iw/a8f3n18Vr3lyz5ik8os/LVSEaYfPKoEIumLDgAFkCik+DPcRKt4aHam8TMur7Obwaql3T6UauWbVfzcc=
In-Reply-To: <20061119183756.GZ7201@pasky.or.cz>
Content-Disposition: inline
X-Google-Sender-Auth: 3cde759d0de99b0d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31932>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmFBF-0000lF-14 for gcvg-git@gmane.org; Mon, 20 Nov
 2006 20:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966562AbWKTTvg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 14:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966590AbWKTTvf
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 14:51:35 -0500
Received: from wr-out-0506.google.com ([64.233.184.235]:64803 "EHLO
 wr-out-0506.google.com") by vger.kernel.org with ESMTP id S966562AbWKTTvf
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 14:51:35 -0500
Received: by wr-out-0506.google.com with SMTP id i22so471855wra for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 11:51:33 -0800 (PST)
Received: by 10.90.71.12 with SMTP id t12mr3816002aga.1164052293398; Mon, 20
 Nov 2006 11:51:33 -0800 (PST)
Received: by 10.90.65.18 with HTTP; Mon, 20 Nov 2006 11:51:32 -0800 (PST)
To: "Petr Baudis" <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

On 11/19/06, Petr Baudis <pasky@suse.cz> wrote:
> On Sun, Nov 19, 2006 at 02:37:42PM CET, Nikolai Weibull wrote:
> > If I do
> >
> > GIT_DIR=$HOME/projects/<project>/.git git ls-files --others
> >
> > from, e.g., $HOME, I get a list of all the files in $HOME and its
> > subdirectories that aren't in said git repository.  Shouldn't --others
> > use $GIT_DIR, instead of ".", or am I missing something here?
>
> git-ls-files --others lists untracked files in the current directory by
> comparing it to the index stored in $GIT_DIR/index and listing files
> present in the current directory but not in the index.

Ah, of course; how silly of me.  Thanks.

