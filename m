From: "Ian Brown" <ianbrn@gmail.com>
Subject: errors in git pull
Date: Fri, 18 Jan 2008 10:49:16 +0200
Message-ID: <d0383f90801180049p1599dd6fmfabcdcad7d9d3275@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 18 09:49:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFmv7-0003Pn-MG
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 09:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbYARItT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 03:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbYARItT
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 03:49:19 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:13205 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbYARItS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 03:49:18 -0500
Received: by py-out-1112.google.com with SMTP id u52so1424970pyb.10
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 00:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=E3BpLQv/dQaUMqVnwydNZE6NHjEfXd22daa3jZFwqGs=;
        b=N7/sUprX2Ghk2e5NNdOxQofGNY1VqPGPRRbZ/lJtf/rFvKyNhvr/0GnOQekRwgqSO6C6Xdl9AUtRAGfqTf1uFDb0SyU/i99dLpHeV/TYZfy4NlX2UxJQigJ64xL+REKngJVW8JP7NXk89G4RphLjFJgvTHFTOjnurJNDL1MdyKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FtywSpJTz2nBs9eWPMYqFv9p9V+qXJl91uqIUhl7v+0UTRm9sc1YexN7/tiX3rad9VTOnS99LJFrorrJdniRuXPY3g0VnSXhYzr5sauCkQbSqA+yffAycSUEW3Zaqm+JXX/yfJI3LvHOZP5VSSLwisIV9IbmTnDg5gs/M+3uc1I=
Received: by 10.35.111.14 with SMTP id o14mr3493466pym.24.1200646156492;
        Fri, 18 Jan 2008 00:49:16 -0800 (PST)
Received: by 10.35.101.13 with HTTP; Fri, 18 Jan 2008 00:49:16 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70979>

Hello,

 I am working agains a linux kernel net git repository.

It occurred to me more than once that when trying to
git-pull a repository I get the following errors; there errors appear
also after I am running
"git-reset --hard".
Any idea what can it be ?
I must add that I did not made changes in my local copy of the repository.

the command I am running is:

git-pull git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-2.6.25.git


Here are the errors I get:

mygateway:/work/src/2.6.25# gitNetPull.sh

mygateway:/work/src/2.6.25# git diff
mygateway:/work/src/2.6.25# gitNetPull.sh
remote: Generating pack...
remote: Done counting 8510 objects.
Result has 7230 objects.
remote: Deltifying 7230 objects...
remote:  100% (7230/7230) done
Indexing 7230 objects...
remote: Total 7230 (delta 6181), reused 6367 (delta 5448)
 100% (7230/7230) done
Resolving 6181 deltas...
 100% (6181/6181) done
909 objects were added to complete this thin pack.
Auto-merged Documentation/feature-removal-schedule.txt
CONFLICT (content): Merge conflict in Documentation/feature-removal-schedule.txt
Auto-merged MAINTAINERS
Auto-merged drivers/connector/cn_queue.c
Auto-merged drivers/connector/connector.c
Auto-merged drivers/net/macvlan.c
Auto-merged drivers/net/niu.c
Auto-merged drivers/net/wireless/b43/xmit.c
Auto-merged include/linux/inetdevice.h
Auto-merged include/linux/netfilter.h
CONFLICT (content): Merge conflict in include/linux/netfilter.h
Auto-merged include/linux/netfilter/Kbuild
Auto-merged include/linux/netfilter/xt_RATEEST.h
CONFLICT (add/add): Merge conflict in include/linux/netfilter/xt_RATEEST.h
Auto-merged include/linux/netfilter/xt_connlimit.h
Auto-merged include/linux/netfilter/xt_rateest.h
CONFLICT (add/add): Merge conflict in include/linux/netfilter/xt_rateest.h
Auto-merged include/linux/tty.h
Auto-merged include/linux/xfrm.h
Auto-merged include/net/fib_rules.h
CONFLICT (content): Merge conflict in include/net/fib_rules.h
Auto-merged include/net/ip_fib.h
Auto-merged include/net/neighbour.h
Auto-merged include/net/netfilter/nf_conntrack_l3proto.h
Auto-merged include/net/raw.h
CONFLICT (content): Merge conflict in include/net/raw.h
Auto-merged include/net/sch_generic.h
Auto-merged include/net/sock.h
Auto-merged include/net/tcp.h
CONFLICT (content): Merge conflict in include/net/tcp.h
Auto-merged include/net/xfrm.h
Auto-merged net/appletalk/aarp.c
Auto-merged net/atm/br2684.c
CONFLICT (content): Merge conflict in net/atm/br2684.c
Auto-merged net/atm/lec.c
Auto-merged net/atm/proc.c
Auto-merged net/ax25/af_ax25.c
Auto-merged net/bridge/br_netfilter.c
Auto-merged net/core/dev.c
Auto-merged net/core/fib_rules.c
CONFLICT (content): Merge conflict in net/core/fib_rules.c
Auto-merged net/core/neighbour.c
CONFLICT (content): Merge conflict in net/core/neighbour.c
Auto-merged net/core/pktgen.c
Auto-merged net/core/skbuff.c
Auto-merged net/core/utils.c
Auto-merged net/dccp/ccids/ccid3.c
CONFLICT (content): Merge conflict in net/dccp/ccids/ccid3.c
Auto-merged net/decnet/dn_route.c
Auto-merged net/ipv4/arp.c
CONFLICT (content): Merge conflict in net/ipv4/arp.c
Auto-merged net/ipv4/devinet.c
CONFLICT (content): Merge conflict in net/ipv4/devinet.c
Auto-merged net/ipv4/fib_frontend.c
CONFLICT (content): Merge conflict in net/ipv4/fib_frontend.c
Auto-merged net/ipv4/fib_hash.c
CONFLICT (content): Merge conflict in net/ipv4/fib_hash.c
Auto-merged net/ipv4/fib_semantics.c
Auto-merged net/ipv4/fib_trie.c
CONFLICT (content): Merge conflict in net/ipv4/fib_trie.c
Auto-merged net/ipv4/inet_lro.c
Auto-merged net/ipv4/ipconfig.c
Auto-merged net/ipv4/netfilter.c
Auto-merged net/ipv4/netfilter/Kconfig
CONFLICT (content): Merge conflict in net/ipv4/netfilter/Kconfig
Auto-merged net/ipv4/netfilter/Makefile
CONFLICT (content): Merge conflict in net/ipv4/netfilter/Makefile
Auto-merged net/ipv4/netfilter/ip_tables.c
CONFLICT (content): Merge conflict in net/ipv4/netfilter/ip_tables.c
Auto-merged net/ipv4/netfilter/ipt_CLUSTERIP.c
Auto-merged net/ipv4/netfilter/ipt_ECN.c
Auto-merged net/ipv4/netfilter/ipt_LOG.c
Auto-merged net/ipv4/netfilter/ipt_MASQUERADE.c
Auto-merged net/ipv4/netfilter/ipt_NETMAP.c
Auto-merged net/ipv4/netfilter/ipt_REDIRECT.c
Auto-merged net/ipv4/netfilter/ipt_REJECT.c
CONFLICT (content): Merge conflict in net/ipv4/netfilter/ipt_REJECT.c
CONFLICT (delete/modify): net/ipv4/netfilter/ipt_TOS.c deleted in
7651a1f7ebe567f9088283f6354a5634b5dccb8e and modified in HEAD. Version
HEAD of net/ipv4/netfilter/ipt_TOS.c left in tree.
Auto-merged net/ipv4/netfilter/ipt_TTL.c
Auto-merged net/ipv4/netfilter/ipt_ULOG.c
Auto-merged net/ipv4/netfilter/ipt_addrtype.c
Auto-merged net/ipv4/netfilter/ipt_ah.c
Auto-merged net/ipv4/netfilter/ipt_ecn.c
CONFLICT (delete/modify): net/ipv4/netfilter/ipt_iprange.c deleted in
7651a1f7ebe567f9088283f6354a5634b5dccb8e and modified in HEAD. Version
HEAD of net/ipv4/netfilter/ipt_iprange.c left in tree.
Auto-merged net/ipv4/netfilter/ipt_recent.c
Auto-merged net/ipv4/netfilter/ipt_ttl.c
Auto-merged net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c
Auto-merged net/ipv4/netfilter/nf_conntrack_proto_icmp.c
Auto-merged net/ipv4/raw.c
CONFLICT (content): Merge conflict in net/ipv4/raw.c
Auto-merged net/ipv4/route.c
Auto-merged net/ipv4/tcp.c
Auto-merged net/ipv4/tcp_cong.c
Auto-merged net/ipv6/datagram.c
Auto-merged net/ipv6/netfilter/Kconfig
CONFLICT (content): Merge conflict in net/ipv6/netfilter/Kconfig
Auto-merged net/ipv6/netfilter/ip6_tables.c
CONFLICT (content): Merge conflict in net/ipv6/netfilter/ip6_tables.c
Auto-merged net/ipv6/netfilter/ip6t_HL.c
Auto-merged net/ipv6/netfilter/ip6t_LOG.c
Auto-merged net/ipv6/netfilter/ip6t_REJECT.c
Auto-merged net/ipv6/netfilter/ip6t_ah.c
Auto-merged net/ipv6/netfilter/ip6t_eui64.c
Auto-merged net/ipv6/netfilter/ip6t_frag.c
Auto-merged net/ipv6/netfilter/ip6t_hbh.c
Auto-merged net/ipv6/netfilter/ip6t_hl.c
Auto-merged net/ipv6/netfilter/ip6t_ipv6header.c
Auto-merged net/ipv6/netfilter/ip6t_mh.c
Auto-merged net/ipv6/netfilter/ip6t_rt.c
Auto-merged net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c
Auto-merged net/ipv6/netfilter/nf_conntrack_proto_icmpv6.c
Auto-merged net/ipv6/raw.c
CONFLICT (content): Merge conflict in net/ipv6/raw.c
Auto-merged net/ipv6/route.c
Auto-merged net/irda/af_irda.c
Auto-merged net/mac80211/ieee80211_ioctl.c
Auto-merged net/netfilter/Kconfig
CONFLICT (content): Merge conflict in net/netfilter/Kconfig
Auto-merged net/netfilter/Makefile
Auto-merged net/netfilter/core.c
Auto-merged net/netfilter/nf_conntrack_core.c
Auto-merged net/netfilter/nf_conntrack_proto_sctp.c
Auto-merged net/netfilter/nf_conntrack_proto_tcp.c
Auto-merged net/netfilter/nf_conntrack_proto_udp.c
Auto-merged net/netfilter/nf_conntrack_proto_udplite.c
Auto-merged net/netfilter/nf_conntrack_standalone.c
CONFLICT (delete/modify): net/netfilter/nf_sysctl.c deleted in
7651a1f7ebe567f9088283f6354a5634b5dccb8e and modified in HEAD. Version
HEAD of net/netfilter/nf_sysctl.c left in tree.
Auto-merged net/netfilter/xt_CLASSIFY.c
Auto-merged net/netfilter/xt_CONNMARK.c
CONFLICT (content): Merge conflict in net/netfilter/xt_CONNMARK.c
Auto-merged net/netfilter/xt_CONNSECMARK.c
Auto-merged net/netfilter/xt_DSCP.c
CONFLICT (content): Merge conflict in net/netfilter/xt_DSCP.c
Auto-merged net/netfilter/xt_MARK.c
CONFLICT (content): Merge conflict in net/netfilter/xt_MARK.c
Auto-merged net/netfilter/xt_NFLOG.c
Auto-merged net/netfilter/xt_NFQUEUE.c
Auto-merged net/netfilter/xt_NOTRACK.c
Auto-merged net/netfilter/xt_RATEEST.c
CONFLICT (add/add): Merge conflict in net/netfilter/xt_RATEEST.c
Auto-merged net/netfilter/xt_SECMARK.c
Auto-merged net/netfilter/xt_TCPMSS.c
Auto-merged net/netfilter/xt_TCPOPTSTRIP.c
CONFLICT (add/add): Merge conflict in net/netfilter/xt_TCPOPTSTRIP.c
Auto-merged net/netfilter/xt_TRACE.c
Auto-merged net/netfilter/xt_comment.c
Auto-merged net/netfilter/xt_connbytes.c
Auto-merged net/netfilter/xt_connlimit.c
Auto-merged net/netfilter/xt_connmark.c
CONFLICT (content): Merge conflict in net/netfilter/xt_connmark.c
Auto-merged net/netfilter/xt_conntrack.c
CONFLICT (content): Merge conflict in net/netfilter/xt_conntrack.c
Auto-merged net/netfilter/xt_dccp.c
Auto-merged net/netfilter/xt_dscp.c
CONFLICT (content): Merge conflict in net/netfilter/xt_dscp.c
Auto-merged net/netfilter/xt_esp.c
Auto-merged net/netfilter/xt_hashlimit.c
Auto-merged net/netfilter/xt_helper.c
Auto-merged net/netfilter/xt_length.c
Auto-merged net/netfilter/xt_limit.c
Auto-merged net/netfilter/xt_mac.c
Auto-merged net/netfilter/xt_mark.c
CONFLICT (content): Merge conflict in net/netfilter/xt_mark.c
Auto-merged net/netfilter/xt_multiport.c
Auto-merged net/netfilter/xt_owner.c
CONFLICT (add/add): Merge conflict in net/netfilter/xt_owner.c
Auto-merged net/netfilter/xt_physdev.c
Auto-merged net/netfilter/xt_pkttype.c
CONFLICT (content): Merge conflict in net/netfilter/xt_pkttype.c
Auto-merged net/netfilter/xt_policy.c
CONFLICT (content): Merge conflict in net/netfilter/xt_policy.c
Auto-merged net/netfilter/xt_quota.c
Auto-merged net/netfilter/xt_realm.c
Auto-merged net/netfilter/xt_sctp.c
Auto-merged net/netfilter/xt_statistic.c
Auto-merged net/netfilter/xt_string.c
Auto-merged net/netfilter/xt_tcpmss.c
Auto-merged net/netfilter/xt_tcpudp.c
Auto-merged net/netfilter/xt_time.c
Auto-merged net/netfilter/xt_u32.c
Auto-merged net/netlink/af_netlink.c
CONFLICT (content): Merge conflict in net/netlink/af_netlink.c
Auto-merged net/rose/af_rose.c
Auto-merged net/sched/sch_htb.c
Auto-merged net/sctp/sm_make_chunk.c
Auto-merged net/sctp/sm_statefuns.c
Auto-merged net/sctp/ulpevent.c
Auto-merged net/x25/x25_forward.c
Auto-merged net/xfrm/xfrm_policy.c
Auto-merged net/xfrm/xfrm_state.c
CONFLICT (content): Merge conflict in net/xfrm/xfrm_state.c
Auto-merged net/xfrm/xfrm_user.c
Automatic merge failed; fix conflicts and then commit the result.


regards,
Ian
