X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: git bug? + question
Date: Fri, 3 Nov 2006 11:27:36 +0100
Message-ID: <8aa486160611030227w4c79ace9ta00a3eecfc46b11a@mail.gmail.com>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com>
	 <7v4pthmew1.fsf@assigned-by-dhcp.cox.net>
	 <20061103074857.GA15972@diana.vm.bytemark.co.uk>
	 <7v3b90gbfv.fsf@assigned-by-dhcp.cox.net>
	 <20061103095905.GD7545@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 3 Nov 2006 10:27:46 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>,
	"=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	"Miles Bader" <miles@gnu.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MHuqyhVUBxQNVJkYA2O9/nLo+1osbvGj1BU25u/TVnOEjPMH4Y198cKXZFdTRcj/ni75Pci63X2NQh5vGl8bW787M8GiqVwy+NSJJDO3iQXIzSzJfDROkmQpaXh6RU9iPZZNX0mfJw8TuLyQ+G3U7xhua91dxOTT7/MEjBTTaUQ=
In-Reply-To: <20061103095905.GD7545@admingilde.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30816>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfwGy-0000tj-DF for gcvg-git@gmane.org; Fri, 03 Nov
 2006 11:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752907AbWKCK1h (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 05:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752908AbWKCK1h
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 05:27:37 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:15752 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1752902AbWKCK1h
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 05:27:37 -0500
Received: by wx-out-0506.google.com with SMTP id s14so374044wxc for
 <git@vger.kernel.org>; Fri, 03 Nov 2006 02:27:36 -0800 (PST)
Received: by 10.70.131.20 with SMTP id e20mr2813570wxd.1162549656438; Fri, 03
 Nov 2006 02:27:36 -0800 (PST)
Received: by 10.70.46.19 with HTTP; Fri, 3 Nov 2006 02:27:36 -0800 (PST)
To: "Martin Waitz" <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

On 11/3/06, Martin Waitz <tali@admingilde.org> wrote:
> I think the most intuitive thing for pull would be to fetch into
> remotes/<remotename>/* and then to merge
> remotes/<remotename>/<currentbranch>.

Yes as the default branch to merge instead the first line, the problem
is that it changes the current behaviour. But I think the most
intuitive thing would be to record the branch it is based off at the
branch creation time. Something similar to my patch:

Oct 17 [PATCHv2] git-branch: Set branch properties
Message-ID: <87y7rf80es.fsf@gmail.com>

Note that it is for the "old" git-branch.sh.

